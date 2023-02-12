clear, clc;

sig = loadbin('SA001S01.CS0');
fs = 16000;
slen = length(sig);
t = (0:slen-1)/fs;

p = 0.98 * [exp(1i*11*pi/12) exp(-1i*11*pi/12)];

a = poly(p);
b = 1;

sig_filtr = filter(b, a, sig);

wlen = 512;

figure(1)
subplot(211)
plot(t, sig), xlim([0 max(t)])
subplot(212)
spectrogram(sig, wlen, [],[],fs, 'yaxis')
colorbar off

scale = 0.002;
n = scale*randn(slen,1);
sigfn = sig_filtr + n;


figure(2)
subplot(211)
plot(t, sigfn), xlim([0 max(t)])
subplot(212)
spectrogram(sigfn, wlen, [],[], fs, 'yaxis')
colorbar off

figure(3)
freqz(b, a, [], fs)


siginv = filter(a,b,sigfn);
figure(4)
subplot(211)
plot(t, siginv), xlim([0 max(t)])
subplot(212)
spectrogram(siginv, wlen, [],[], fs, 'yaxis')
colorbar off


SNR1 = 10*log10(mean(sig_filtr.^2)/mean(n.^2))
SNR2 = 10*log10(mean(sig.^2)/mean((siginv-sig).^2))
