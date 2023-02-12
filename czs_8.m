n = (-200:200)

Wc = 0.5;
hid = (Wc).*sinc((Wc)*n);

M = 300;

nfir = -M/2:M/2
hfir = (Wc)*sinc((Wc)*nfir);
hfir = hfir(:);

w = hamming(M+1)
w = w(:);
hfir=hfir.*w;

figure(1)
plot(hid)

figure(2)
[H,F] = freqz(hfir,1,1000)

figure(3)
subplot(211)
plot(F, abs(H))
subplot(212)
plot(F,20*log10(abs(H)))

lfir = fir1(M,0.5,blackman(M+1));
hfir = fir1(M,0.5,'high',blackman(M+1));

figure(4)
freqz(lfir)
%hold on 
figure(5)
freqz(hfir)
%hold off

fc = [300 3400];
fs = 16000;

pfir = fir1(M,fc/(fs/2),blackman(M+1));
pfir2 = fir1(M,fc/(fs/2));


[H2,F2] = freqz(pfir,1,fs);
[H3,F3] = freqz(pfir2,1,fs);

figure(6)
plot(F2*fs/2/pi,20*log10(abs(H2)))
hold on
plot(F3*fs/2/pi,20*log10(abs(H3)))
hold off

figure(7)
impz(pfir)

load speech_8_16_44.mat



figure(8)
% plot(sig16)
% hold on 
plot(filter(pfir, sig16))
xlim([2000 4000])
% hold off
