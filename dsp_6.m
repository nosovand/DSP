s = loadbin("SA001S04.CS0");
fs = 16000;
wlen = 0.032*fs; %segment 32ms

figure(1)
subplot(211)
plot(s); axis tight

subplot(212)
spectrogram(s, wlen, [], [], fs, "yaxis")
colorbar off

cp = 12;
cepr = vrceps(s, 1, cp, wlen, wlen/2);%kepstrum originalniho signalu

figure(3)
plot(cepr(:,2:end)) %zobrazeni kepstralnich koeficientu bez c0
axis tight

M = 30; %rad filtru
Wc = 0.3; %normovany mezni kmitocet
b = fir1(M, Wc, "high");
a = 1;

figure(4)
freqz(b,a,1000)

sf = filter(b,a,s);

figure(5)
subplot(211)
spectrogram(sf, wlen, [], [], fs, "yaxis")
colorbar off

ceprf = vrceps(sf, 1, cp, wlen, wlen/2); %kepstrum filtrovaneho signalu

cdist = cde(cepr(:,2:end),ceprf(:,2:end)); %vypocet euklidovske kepstralni vzdalenosti dvou signalu bez koeficientu c0

subplot(212)
plot(cdist);
axis tight

meancd = mean(cdist(90:250));

title(sprintf('Mean CDE: %f', meancd))


%%
[y,fs] = audioread('sinusovky.wav');
[y,fs] = audioread('fletna_stupnice.wav');
wlen = 256;
cp = 16;
p = 16;
cepr = vrceps(y, 1, cp, wlen, wlen/2);%kepstrum originalniho signalu
%cepr = vaceps(y,1,p,cp,wlen,wlen/2);%komplexni kepstrum
wnum = length(cepr(:,1));
wstep = length(y)/wnum;
cdist = zeros(wnum-1,1);
for ii=1:wnum-1
    cdist(ii) = cde(cepr(ii,2:end),cepr(ii+1,2:end));
end
tt = wstep*(0:wnum-2)/fs;
figure(6)
subplot(211)
spectrogram(y, wlen, [], [], fs, "yaxis")
colorbar off
subplot(212)
plot(tt,cdist) %zobrazeni kepstralnich koeficientu bez c0
axis tight

