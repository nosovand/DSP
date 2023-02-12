load speech_8_16_44.mat
fs = 16000;
fs2 = 16000;
fs3 = 44000;
Wp = [400 3300];
Ws = [200 3550];
Rs = 40;
Rp = 1;

[N, Wc] = buttord(Wp/(fs/2), Ws/(fs/2), Rp, Rs);
%[N2, Wc2] = buttord(Wp/(fs2/2), Ws/(fs2/2), Rp, Rs);
%[N3, Wc3] = buttord(Wp/(fs3/2), Ws/(fs3/2), Rp, Rs);
[N2, Wc2] = cheb1ord(Wp/(fs/2), Ws/(fs/2), Rp, Rs);
[N3, W3c] = cheb2ord(Wp/(fs/2), Ws/(fs/2), Rp, Rs);
[N4, W4c] = ellipord(Wp/(fs/2), Ws/(fs/2), Rp, Rs);
N
N2
N3
N4

[b, a] = butter(N,Wc);
%[b2, a2] = butter(N2,Wc2);
%[b3, a3] = butter(N3,Wc3);
[b2, a2] = cheby1(N2, Rp, Wc2);
[b3, a3] = cheby2(N2, Rs, Wc2);
[b4, a4] = ellip(N4, Rp, Rs, W4c);

fsig8 = filter(b , a, sig8);


figure(1)
freqz(b, a, 1000)
title('butter')

figure(2)
freqz(b2, a2, 1000)
title('cheby1')

figure(3)
freqz(b3, a3, 1000)
title('cheby2')

figure(4)
freqz(b4, a4, 1000)
title('ellip')

figure(5)
subplot(411)
impz(b ,a)
subplot(412)
impz(b2, a2)
subplot(413)
impz(b3, a3)
subplot(414)
impz(b4, a4)

figure(6)
zplane(b4,a4)

L = 201;
beta = 0;
w = kaiser(L, beta);
w2 = kaiser(L, 2);
w3 = kaiser(L, 15);

w = w(:);
w2 = w2(:);
w3 = w3(:);

figure(7)
plot(w)
hold on
plot(w2)
plot(w3)
hold off

figure(8)
plot(abs(fft(w,1024)))
hold on
plot(abs(fft(w2, 1024)))
plot(abs(fft(w3, 1024)))
hold off


f = [200, 400, 3300, 3500];
amp = [0, 1, 0];
dev = [10^(-Rs/20), 1-10^(-Rp/20), 10^(-Rs/20)]; %prevod z log do lin
                                    %dev udava odchylku od idealniho filtru

[N5, Wc5, beta, ftype] = kaiserord(f,amp,dev, fs);

b5 = fir1(N5, Wc5,ftype,kaiser(N5+1,beta))
N5

figure(9)
freqz(b5)

figure(10)
impz(b5)

figure(11)
zplane(b5)


[N6, f0, a0, W6] = firpmord(f,amp,dev, fs);

b6 = firpm(N6, f0, a0, W6);

N6

figure(12)
freqz(b6)

figure(13)
impz(b6)

figure(14)
zplane(b6)