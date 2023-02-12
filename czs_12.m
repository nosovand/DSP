loadbin s0001.bin;
fs=8000;
fs0 = fs/4;

b1 = fir1(30, (fs0*2)/fs, 'low')
b2 = fir1(30, (fs0*2)/fs, 'high')


sig1 = filter(b1, 1, ans);
sig2 = filter(b2, 1, ans);

figure(1)
subplot(211)
plot(sig1)
subplot(212)
plot(sig2)

figure(2)
freqz(b1)
figure(3)
freqz(b2)

figure(4)
subplot(211)
spectrogram(sig1, 0.032*fs, 'yaxis')
colorbar off
subplot(212)
spectrogram(sig2, 0.032*fs, 'yaxis')
colorbar off

z0 = downsample(sig1, 2);
z1 = downsample(sig2, 2);

figure(5)
subplot(211)
spectrogram(z0, 0.032*fs/2, 'yaxis')
colorbar off
subplot(212)
spectrogram(z1, 0.032*fs/2, 'yaxis')
colorbar off

w0 = upsample(z0, 2);
w1 = upsample(z1, 2);

y0 = filter(b1, 1, w0);
y1 = filter(b2, 1, w1);

y = y0+y1;
y = y(1:end-1);
y = y(1+30:end);
ans = ans(1:end-30);

figure(6)
subplot(211)
plot(y.*2) %zbyla pouze polovicni energie a proto *2
title('vystup')
subplot(212)
plot(ans)
title('vstup')

figure(7)
subplot(211)
spectrogram(y.*2, 0.032*fs, 'yaxis')
title('vystup')
colorbar off
subplot(212)
spectrogram(ans, 0.032*fs, 'yaxis')
title('vstup')
colorbar off


figure(8)
subplot(211)
impz(b1)
subplot(212)
impz(b2)


