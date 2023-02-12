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

x = s+n1;

y1 = conv(h,x);

slen = length(x);
NFFT = 512;
wlen = 512;
w = hamming(wlen);
wstep = wlen/4;
w = w(:);
x = x(:);
scale = sum(w(1:wstep:end));

wnum=floor(((slen-wlen)/wstep)+1);

y=zeros(slen,1);
Hframe = fft(h, 512);
prah = 25;

for i=1:wnum;
    ii = (i-1)*wstep+1;
    jj = (i-1)*wstep+wlen;
    xframe = x(ii:jj).*w;
    X=fft(xframe,NFFT);
    Y = X.*Hframe;%.*(abs(X)>prah);
    yframe = ifft(Y,NFFT);
    y(ii:jj)=y(ii:jj)+yframe./scale; %skalovani apmlitudy
end

figure(1)
plot(y)
hold on
plot(y1)
hold off

figure(2)
plot(abs(Y))
