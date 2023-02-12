% % sin
% 
% A=1;
% f=1000;
% fs=8000;
% to=0.5;
% tt=0:1/fs:to-1/fs;
% tt=tt(:);
% s1 = A*sin(2*pi*f*tt);
% w = hamming(wlen);
% %w = rectwin(wlen);
% wlen = 509; %wlen=NFFT
% NFFT=wlen;
% x=s1(1:wlen);
% x = x.*w; %vahovani signalu hammingem
% X=fft(x);
% P=(abs(X).^2)./wlen; %VYKOnove spektrum
% P=P(:);
% Pdb=10*log10(P);
% 
% ff = (0:fs/NFFT:fs-fs/NFFT); %wlen=NFFT
% 
% 
% figure(1)
% plot(x)
% 
% figure(2)
% subplot(221)
% plot(abs(X))
% subplot(222)
% plot(ff,P)
% subplot(223)
% plot(ff,Pdb)
% 


load x_spl.mat;

wlen = length(x);
NFFT=wlen;
fsx = 1000;
w0 = rectwin(wlen);
w1 = hamming(wlen);
w2 = blackman(wlen);
x=x(:);
x0=x.*w0;
x1=x.*w1;
x2=x.*w2;
figure(10)
plot(x0)
hold on
plot(x1,'r')
plot(x2,'g')
hold off

Gxdb0=10*log10((abs(fft(x0).^2))./NFFT);
Gxdb1=10*log10((abs(fft(x1).^2))./NFFT);
Gxdb2=10*log10((abs(fft(x2).^2))./NFFT);

ff=0:fsx/NFFT:fsx-fsx/NFFT;
figure(11)
plot(ff,Gxdb0)
hold on
plot(ff,Gxdb1, 'r')
plot(ff,Gxdb2, 'g')
hold off

%%
sig = loadbin('vm7.bin');

wlen = length(sig);
NFFT = 8*wlen;
fss=16000;
x = sig(1:wlen);
w0 = rectwin(wlen);
w1 = hamming(wlen);
w2 = blackman(wlen);
x=x(:);
x0=x.*w0;
x1=x.*w1;
x2=x.*w2;

Gxdb0=10*log10((abs(fft(x0,NFFT).^2))./NFFT);
Gxdb1=10*log10((abs(fft(x1,NFFT).^2))./NFFT);
Gxdb2=10*log10((abs(fft(x2,NFFT).^2))./NFFT);
ff=0:fss/NFFT:fss-fss/NFFT;
figure(12)
plot(x)

figure(13)
plot(ff,Gxdb0)
hold on
plot(ff,Gxdb1, 'r.-')
plot(ff,Gxdb2, 'g.-')
hold off

%%

load sig1.mat
load sig2.mat

fss=200;

ff=0:fss/NFFT:fss-fss/NFFT;

figure(20)
subplot(211)
plot(sig1)
subplot(212)
plot(sig2)

wlen=length(sig1)
NFFT=1024;
GS1=abs(fft(sig1,NFFT).^2)./NFFT;
GS2=abs(fft(sig2,NFFT).^2)./NFFT;

figure(21)
subplot(221)
plot(GS1)
subplot(222)
plot(GS2)


