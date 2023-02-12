%Dsikretni kosinova transformace

clear,clc,close all;

 x = [10 7 4 1 -2 -5 -8 -5 -2 1];
 x1 = [x x(end-1:-1:2)];
 %x1 = [x fliplr(x(2:end))]; %otoceni a prodlouzeni posloupnosti
N = length(x);
n = 0:N-1;

 Xdct = dctxc1(x);%vypocet DCT1
 Xfft = real(fft(x1));
    n1 = 0:2*N-2-1;

 figure(1)
 subplot(221), stem([x zeros(1,N-1)])
 subplot(222), plot(n,Xdct)
 subplot(223), stem(x1)
 subplot(224), plot(n1,Xfft)

 n2 = 0:2*N-1;
 x2 = [x x(end:-1:1)];
 Xdct = dctxc2(x);
Xfft = real(fft(x2.*exp(-1i*pi*n2/(2*N))));

 figure(2)
 subplot(221), stem([x zeros(1,N-1)])
 subplot(222), plot(n,Xdct)
 subplot(223), stem(x2)
 subplot(224), plot(n2,Xfft)

 %%
clear,clc,close all;

x = loadbin('frame.bin');
fs = 8000;
N = length(x);

Xlog = log(abs(fft(x))); %log spektrum

cxfft = ifft(Xlog); %kepstrum pomoci ifft
cxdct = idctxc1(Xlog(1:N/2+1)); %fepstrum pomoci idct

figure(5)
plot(cxfft),hold on, plot(cxdct), hold off