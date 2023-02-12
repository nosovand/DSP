
% sin

A=1;
f=15;
fs=200;
to=10;
tt=0:1/fs:to-1/fs;
s1 = A*sin(2*pi*f*tt);

figure(1)
plot(s1)

[Rs1_bias, lags] = xcorr(s1, 'biased');
[Rs2_unbias, lags] = xcorr(s1, 'unbiased');
[Rs3_coeff, lags] = xcorr(s1, 'coeff');
[Rs4_none, lags] = xcorr(s1, 'none');

figure(2)
subplot(221)
plot(lags, Rs1_bias)
subplot(222)
plot(lags, Rs2_unbias)
subplot(223)
plot(lags, Rs3_coeff)
subplot(224)
plot(lags, Rs4_none)

%noise 1

pb1=0.7;
N=fs*to;
b1=sqrt(0.7)*randn(1,N);
%b1=wgn(1,N,-1.55);

[Rb1_bias, lags] = xcorr(b1, 'biased');
[Rb2_unbias, lags] = xcorr(b1, 'unbiased');
[Rb3_coeff, lags] = xcorr(b1, 'coeff');
[Rb4_none, lags] = xcorr(b1, 'none');

figure(3)
subplot(321)
plot(lags, Rb1_bias)
subplot(322)
plot(lags, Rb2_unbias)
subplot(323)
plot(lags, Rb3_coeff)
subplot(324)
plot(lags, Rb4_none)

%noise2

%N=2000;
%b2=wgn(1,N,-1.55);

%vykon

Ps1=mean(s1.^2);
Pb1=mean(b1.^2);
SNR=-10;

k = sqrt(Ps1/Pb1*10^(-SNR/10));

%pridame stejnosmernou slozku

x=k*b1+s1;
[Rx_bias, lags] = xcorr(x, 'biased');
[Rx_unbias, lags] = xcorr(x, 'unbiased');

figure(4)
subplot(221)
plot(x)
title('Waveform')
xlabel('n')
ylabel('y')
subplot(222)
plot(lags, Rx_bias)
title('Biased odhad')
subplot(223)
plot(lags, Rx_unbias)
title('Unbiased odhad')


%%

%analyza audio

[sig, fs]=audioread('housle_d_dur_5.wav');
figure(5)
plot(sig)

tlen=0.01;
wlen=fs*tlen;

x = sig(20000:20400);

x = loadbin('vm3.bin');

x = x(1:500)
[Rx_bias, lags] = xcorr(x, 'biased');
[Rx_unbias, lags] = xcorr(x, 'unbiased');
figure(5)
subplot(221)
plot(x)
title('Waveform')
xlabel('n')
ylabel('y')
subplot(222)
plot(lags, Rx_bias)
title('Biased odhad')
subplot(223)
plot(lags, Rx_unbias)
title('Unbiased odhad')


