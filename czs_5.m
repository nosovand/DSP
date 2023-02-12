zplane([1 -0.97]);
freqz([1 -0.97], [1], 2000, 16000, 'whole')
fs = 16000;
N=20000;
x1=randn(1,N);
x1 = x1(:);
%%x1 = loadbin('sm2.bin');

tt = (0:length(x1)-1./fs);

y1 = filter([1 -0.97], [1], x1);

figure(3)
pwelch(x1, 512, [], [], fs)

figure(4)
pwelch(y1, 512, [], [], fs)


% figure(1)
% subplot(111)
% plot(x1)
% subplot(121)
% plot(y1)
% 
% Px1 = mean(x1.^2);
% Py1 = mean(y1.^2);
% 
% 
% 
% X1 = fft(x1);
% Y1 = fft(y1);
% 
% 
% 
% figure(2)
% subplot(221)
% plot(abs(X1))
% subplot(222)
% plot(abs(Y1))

figure(5)
subplot(511)
plot(tt,y1)
subplot(512)
spectrogram(y1, 512, [],[],'yaxis')

figure(6)
subplot(611)
plot(tt,x1)
subplot(612)
spectrogram(x1, 512, [],[],'yaxis')

figure(7)
freqz([1], [1 0.8]);


