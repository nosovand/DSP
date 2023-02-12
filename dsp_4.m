sig = loadbin("SA001S01.CS0");

delay = 20;

sim1s1 = sig(delay+1:end);
sim1s2 = sig(1:end-delay);

figure(1)
subplot(211), plot([sim1s1, sim1s2])

M = 30;%rad filtru
Wn = 0.001; %normovany mezni kmitocet
G = 0.001; %potlaceni sumu

sim2s1 = sig + G*randn(length(sig), 1);

b = fir1(M, Wn, 'high');

sim2s2 = filter(b, 1, sig) + G*randn(length(sig), 1);

subplot(212), plot([sim2s1, sim2s2])

figure(2)
freqz(b,1)

figure(3)
impz(b,1)

%%

siglen = 3000;
start = 20000;%vezmeme jen kus signalu pro lepsi prehlednost

% x1 = sim1s1(start+1:start+siglen);
% x2 = sim1s2(start+1:start+siglen);
x1 = sim2s1(start+1:start+siglen);
x2 = sim2s2(start+1:start+siglen);


[R12, lags] = xcorr(x1, x2); %korelacni funkce dvou signalu

[~,ix] = max(R12); %hledame maximum a ajeho index => delay
delay = lags(ix)

figure(4)
plot(lags, R12), grid
title(['delay = ' num2str(delay) ' samples'])

%%

wlen = 512;
fs = 16000;
noverlap = wlen/2;
N = wlen;

[S12, ff] = cpsd(x1, x2, wlen, noverlap, N, fs)

figure(5)
subplot(211), plot(ff, 10*log10(abs(S12)))
subplot(212), plot(ff, unwrap(angle(S12)))

%%

wlen2 = 512;
noverlap2 = 3*wlen2/4;
nfft2 = max([wlen2 256]);

figure(6)
mscohere(x1, x2, wlen2, noverlap2, nfft2, fs) %vypocet koherencni funkce

%%

slen = length(sim2s1);
wlen = 1024; %segmentace signalu
wstep = wlen/4; %krok segmentace
overlap = wlen - wstep; %prekryti segmentace
wnum = floor((slen-wlen)/wstep)+1; %pocet segmentu signalu

wlen2 = 256;%segmentace segmentu pro vypocet msc
noverlap2 = 3*wlen2/4; %prekryti pro vypocet msc
nfft = max([wlen2 256]);

MSC_Matrix = zeros(nfft/2+1, wnum);

for n = 0:wnum-1
    nn = n*wstep+1;
    kk = n*wstep+wlen;
    frame1 = sim2s1(nn:kk);
    frame2 = sim2s2(nn:kk);
    [msc, ff] = mscohere(frame1, frame2, wlen2, noverlap2, nfft, fs);
    MSC_Matrix(:,n+1) = msc;

end

figure(7)
t = 1:nfft/2+1;
x = 1:wnum;

t = t.*62,5;
x = x.*(slen/wnum)

p = (0:slen-1)/fs;
pp = wstep*(1:wnum)/fs;

surf(x,t,abs(MSC_Matrix),'EdgeColor','none');   
axis xy; axis tight; colormap(jet); view(0,90);