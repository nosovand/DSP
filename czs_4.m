A1=0.5;
f1=14;
A2 = 0.4;
f2 = 27.5;

fs=200;
to=100;

wlen = 512;

tt=0:1/fs:to-1/fs;
s1=A1*sin(2*pi*f1*tt) + A2*sin(2*pi*f2*tt);
s1=s1(:);

Pb1 = 1;

b1 = sqrt(Pb1)*randn(1,length(s1));
b1 = b1(:);

Ps1 = mean(s1.^2)

SNR = -3;

k = sqrt((Ps1/Pb1)*10^(-SNR/10));

x1 = s1 + k*b1;

seg1 = x1(1:wlen);
seg2 = x1(wlen+1:wlen+wlen);

figure(1)
subplot(221)
plot(seg1)
subplot(222)
plot(seg2)

S1 = fft(seg1);
S2 = fft(seg2);
NFFT = wlen;
Gs1db = 10*log10(abs(S1.^2)/NFFT);
Gs2db = 10*log10(abs(S2.^2)/NFFT);
ff=0:fs/NFFT:fs-fs/NFFT;

figure(2)
plot(ff, Gs1db, 'b.-')
hold on
%plot(ff, Gs2db, 'r.-')
hold off

x1 = x1(1:4000);

figure(3)
pwelch(x1,wlen, wlen*0.75)
figure(4)
pwelch(seg1)

load e1.mat

figure(5)
plot(e1)
pwelch(e1)


