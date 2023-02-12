% fc = 800;
% fs = 8000;
% N = 6;
% 
% [b,a] = butter(N, 2*fc/fs);
% 
% [H,F] = freqz(b,a,1000,fs);
% 
% max(abs(roots(a)))
% 
% figure(1)
% freqz(b,a,1000)
% ylim([-60 0])
% 
% figure(2)
% zplane(b,a)
% 
% figure(3)
% subplot(211)
% plot(F, abs(H))
% subplot(212)
% plot(F, 20*log10(abs(H)))
% ylim([-60 0])
% xlim([0 4000])
% 
% figure(4)
% impz(b,a)


fc = 800;
fs = 8000;
N = 6;

%[b,a] = cheby1(N, 3 , 2*fc/fs);
%[b,a] = cheby2(N, 3 , 2*fc/fs);
[b,a] = ellip(N, 0.5 ,10 ,2*fc/fs);

[H,F] = freqz(b,a,1000,fs);

max(abs(roots(a)))

figure(1)
freqz(b,a,1000)
ylim([-60 0])

figure(2)
zplane(b,a)

figure(3)
subplot(211)
plot(F, abs(H))
subplot(212)
plot(F, 20*log10(abs(H)))
ylim([-60 0])
xlim([0 4000])

figure(4)
impz(b,a)