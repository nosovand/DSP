A=1;
f=2123;
fs=8000;
to=0.1;

tt=0:1/fs:to-1/fs;
s=A*sin(2*pi*f*tt); %generovani sin

Npoints=1000;
fs = 8000; %vzorkovaci kmitocet

N = 10000;
n=rand(1,N); %rovnomerne rozdeleni
un=randn(N, 1); %gaussovske rozdeleni

B = 300; %sirka pasma

a1_abs = exp(-(B*pi)/fs); %abs hodnota koeficient filtru AR
a = [1, -a1_abs]; %AR
b = 1; %AR

%MA 1. radu
a = 1;
b = [1, a1_abs];

%AR 2. radu
p = [0.9*exp(-j*0.9), 0.9*exp(j*0.9)]
%a = poly(p);
%b = 1;

figure(1);
freqz(b,a ,Npoints,fs)

nc1 = filter(b,a,un); %filtrace sumu = generace barevneho sumu

figure(2)
subplot(211), plot(un)
subplot(212), plot(nc1)

wlen = 512;
figure(3)
pwelch(nc1,wlen,wlen/2,wlen,fs, 'onesided')%vykonove spektrum pomoci welch
figure(4)
plot(10*log10(abs(fft(nc1(1:wlen))).^2/wlen)), xlim([0 wlen/2]) %vykonove spektrum pomoci fft

figure(5)
spectrogram(nc1, wlen, wlen/2, wlen, fs, 'yaxis')

figure(6)
zplane(b, a)

%%LPC

p = 1; %rad modelovaciho filtru
a_lpc = lpc(nc1,p)%odhad koeficientu modelovaciho filtru

r = roots(a_lpc) %koreny filtru


figure(6)
hold on
plot(real(r), imag(r), 'rx')
hold off

figure(7)
freqz(1, a_lpc, Npoints, fs)

%%
nc4 = loadbin("nc4.bin");
fs = 8000;

figure(10)
pwelch(nc4,wlen,wlen/2,wlen,fs, 'onesided')%vykonove spektrum pomoci welch
% ve spektru jsou dve spicky -> odhadujeme 4. rad filtru
p = 4;
a_lpc = lpc(nc4,p)%odhad koeficientu modelovaciho filtru
r = roots(a_lpc) %koreny filtru

figure(11)
freqz(1, a_lpc)

figure(12)
zplane(1, a_lpc)

%%

sig = loadbin("vm0-512.bin");
fs = 16000;
w = hamming(length(sig));
sig = sig.*w;

figure(21)
plot(sig)

figure(22)

wlen = length(sig);
plot(10*log10(abs(fft(sig(1:wlen))).^2/wlen)), xlim([0 wlen/2]) %vykonove spektrum pomoci fft

p = 16;%vime z navodu
[aa, Ep] = lpc(sig, p);% aa=koeficienty modelovaciho filtru
%Ep = rozptyl chyboveho signalu

figure(22)
Hz = freqz(sqrt(Ep), aa, wlen/2);
hold on
plot(20*log10(abs(Hz)))
hold off
