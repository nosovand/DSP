N=10000;
x=randn(1,N);

fc = 800;
fs = 8000;
N = 6;
[b1,a1] = butter(N, 2*fc/fs);
[b2,a2] = cheby1(N, 0.5 , 2*fc/fs);
[b3,a3] = cheby2(N, 30 , 2*fc/fs);
[b4,a4] = ellip(N, 0.5 ,30 ,2*fc/fs);

[H1,F1] = freqz(b1,a1,1000,fs);
[H2,F2] = freqz(b2,a2,1000,fs);
[H3,F3] = freqz(b3,a3,1000,fs);
[H4,F4] = freqz(b4,a4,1000,fs);

y1 = filter(b1, a1, x);
y2 = filter(b2, a2, x);
y3 = filter(b3, a3, x);
y4 = filter(b4, a4, x);


figure(1)
subplot(411)
spectrogram(y1, 256)
subplot(412)
spectrogram(y2, 256)
subplot(413)
spectrogram(y3, 256)
subplot(414)
spectrogram(y4, 256)

figure(2)
plot(F1, 20*log10(abs(H1)))
hold on
plot(F2, 20*log10(abs(H2)))
plot(F3, 20*log10(abs(H3)))
plot(F4, 20*log10(abs(H4)))
hold off
ylim([-40 0])
xlim([0 4000])