clear, clc, close all;
f = 821;
fs = 8000;
slen = 2000;
scale = 0.001;

t = (0:slen-1)/fs;
s1 = sin(2*pi*f*t);
n1 = scale*randn(1,slen);

f1 = 532;
f2 = 640;

s2 = sin(2*pi*f1*t)+sin(2*pi*f2*t);


r1 = loadbin('vm0.bin');
r1 = r1(:);

sig = r1+n1;



wlen = 200;
wstep = 50;

SS = [];
for i = 1:20
    ii = (i-1)*wstep+1;
    jj = (i-1)*wstep+wlen;

    SS = [SS; sig(ii:jj)];
end

Rss = SS'*SS;

%%

[V, D] = eig(Rss);
d = diag(D);
d = flipud(d);%aby nejpodstatnejsi vlastni cisla byla jako prvni
V = fliplr(V);

figure(1)
plot(SS(1,:))

figure(2)
stem(d)

figure(3)
for(k = 1:4)
subplot(4,1,k), plot(V(:,k))
end

%%

x = SS(1,:)';

Wklt = V';

Xklt = Wklt*x;
Xdft = fft(x);
Xdct = dctxc1(x);

figure(4)
subplot(311), plot(abs(Xklt), '*-')
subplot(312), plot(abs(Xdft), '*-')
subplot(313), plot(abs(Xdct), '*-')

%%
Xdft = Xdft(1:end/2+1); %odstranime symetrii z dft
Xdft(2:end-1) = 2*Xdft(2:end-1);

csXklt = cumsum(abs(Xklt))/sum(abs(Xklt));
csXdft = cumsum(abs(Xdft))/sum(abs(Xdft));
csXkdct = cumsum(abs(Xdct))/sum(abs(Xdct));

figure(5)
subplot(321), plot(abs(Xklt), '.-')
subplot(323), plot(abs(Xdft), '.-')
subplot(325), plot(abs(Xdct), '.-')

subplot(322), plot(abs(csXklt), '.-')
subplot(324), plot(abs(csXdft), '.-')
subplot(326), plot(abs(csXkdct), '.-')



