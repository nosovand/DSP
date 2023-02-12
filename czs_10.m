A=1;
f=12;
fs=8000;
to=0.5;

tt=0:1/fs:to-1/fs;
s=A*sin(2*pi*f*tt);
s = s(:);

N=4000;
n1=randn(1,N);
n1=n1(:);

M = 100;
h = 1/(M+1)*ones(M+1,1);
h = h(:);

s1 = s+n1;

figure(1)
plot(s1)

figure(2)
stem(h)

y1 = conv(h,s1);

figure(3)
plot(y1)

NFFT = N+M;
S1 = fft(s1, NFFT);
H = fft(h, NFFT);
Y2 = S1.*H;
y2 = ifft(Y2, NFFT);

figure(4)
plot(y2)
hold on;
plot(y1)
hold off



slen = length(s1);
wlen = 512;
wnum=floor(slen/wlen);

y3=[];

Hframe = fft(h, wlen);

for i=1:wnum;
    ii = (i-1)*wlen+1;
    jj = (i-1)*wlen+wlen;
    frame = s1(ii:jj);
    X=fft(frame,wlen);
    Y = X.*Hframe;
    yframe = ifft(Y);
    y3 = [y3;yframe];
end

figure(5)
plot(y3)
hold on
plot(y1)
hold off


%OLS

slen = length(s1);
wlen = 512;
overlap = M;
wstep = wlen-overlap;

wnum=floor(((slen-wlen)/wstep)+1);

y4=[];
Hframe = fft(h, wlen);


for i=1:wnum;
    ii = (i-1)*wstep+1;
    jj = (i-1)*wstep+wlen;
    frame = s1(ii:jj);
    X=fft(frame,wlen);
    Y = X.*Hframe;
    yframe = ifft(Y);
    y4 = [y4;yframe(overlap+1:end)]
end

figure(6)
plot(y4)
hold on
plot(y1)
hold off

%OLA

slen = length(s1);
NFFT = 512;
wlen = NFFT-overlap;
overlap = M;
wstep = wlen;

wnum=floor(((slen-wlen)/wstep)+1);

y5=zeros(slen+overlap,1);
Hframe = fft(h, 512);


for i=1:wnum;
    ii = (i-1)*wstep+1;
    jj = (i-1)*wstep+wlen;
    frame = s1(ii:jj);
    X=fft(frame,NFFT);
    Y = X.*Hframe;
    yframe = ifft(Y,NFFT);
    y5(ii:jj+overlap)=y5(ii:jj+overlap)+yframe;
end

figure(7)
plot(y5)
hold on
plot(y1)
hold off
