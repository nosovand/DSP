%Kepstralni analyza

%generace signalu
%aperiodicky
A=1;
f=500;
fs=8000;
to=0.0125;
Tau = 0.001;
tt=0:1/fs:to-1/fs;
s1 = A*cos(2*pi*f*tt) .* exp(-tt/Tau);

figure(1)
subplot(311)
plot(s1)

%periodicky
N = 100;
M=15;
m=0.7;
h = zeros(N,1);
h(1) = 1;
h(M+1) = m;

figure(1)
subplot(312)
plot(h)

length(s1)
length(h)
%spojeni aperiodickeho a periodickeho signalu
x = filter(h,1, s1)

figure(1)
subplot(313)
plot(x)
%ziskani abs spektra
S = abs(fft(s1));
H = abs(fft(h));
X = abs(fft(x));

figure(2)
subplot(311), plot(20*log10(S))
subplot(312), plot(20*log10(H))
subplot(313), plot(20*log10(X))
%ln ze spektra
LNS = log(S);
LNH = log(H);
LNX = log(X);

figure(3)
subplot(311), plot(LNS)
subplot(312), plot(LNH)
subplot(313), plot(LNX)

%kepstrum
keps = ifft(LNS);
keph = ifft(LNH);
kepx = ifft(LNX);

figure(4)
subplot(311), plot(keps)
subplot(312), plot(keph)
subplot(313), plot(kepx)

%oddeleni aperiodicke slozky na zacatku kepstra
L=12;
lmask = [ones(L+1,1); zeros(N-2*L-1,1); ones(L,1)];
lmask = lmask.';
cxlift = kepx .*lmask;

figure(4)
hold on
subplot(313), plot(cxlift)
hold off

Xlift = exp(fft(cxlift));
Xlift = real(Xlift);

figure(2)
subplot(311), hold on, plot(20*log10(Xlift)), hold off;
subplot(313), hold on, plot(20*log10(Xlift)), hold off;


%%
clear,clc,close all

N = 512;
s = loadbin('vm0.bin');
s = s(end-N+1:end);
s = s.*hamming(N);

S = abs(fft(s));
cs = rceps(s);

figure(5)
subplot(311), plot(s)
subplot(312), plot(20*log10(S))
subplot(313), plot(cs)


%oddeleni aperiodicke slozky na zacatku kepstra
L=16;
lmask = [ones(L+1,1); zeros(N-2*L-1,1); ones(L,1)];

cslift = cs.*lmask;


Slift = exp(fft(cslift));
Slift = real(Slift);


figure(5)
subplot(313), hold on , plot(cslift) , hold off
subplot(312), hold on , plot(20*log10(Slift)), hold off