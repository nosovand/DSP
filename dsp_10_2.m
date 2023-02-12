% EXAMPLE OF OLA-GENERAL IMPLEMENTATION 
%  (without any modification)

addpath H:\VYUKA\DSP\m
addpath H:\VYUKA\DSP\signaly

% addpath /home/pollak/www/html/vyu/b2m31dsp/m
% addpath /home/pollak/www/html/vyu/b2m31dsp/signaly

% Loading of clean signal
%%%%%%%%%%%%%%%%%%%%%%%%%

clean = loadbin('SA001S01.CS0');

fs = 16000;
slen = length(sig);
t = (0:slen-1)/fs;

p = 0.98 * [exp(1i*11*pi/12) exp(-1i*11*pi/12)];

a = poly(p);
b = 1;
sig = filter(b,a,clean);


%Modeling of noise
%%%%%%%%%%%%%%%%%%%%
scale = 0.002;
noise = scale*randn(slen,1);
Sn = myPwelch(noise, wlen,wstep);
sig = sig+noise;

%SNR
%%%%%%%%%%%%%%%%%%%%%%
SNR = 10*log10(mean(clean.^2)/mean(noise.^2))

% Computation of short-time frame amount (50% overlap)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
slen=length(sig);
wlen=512 ;
wstep=wlen/2 ;
wnum=(slen-wlen)/wstep+1 ;

w=hamming(wlen);



% Vykresleni vstupniho signalu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1); clf ;
subplot(211);
plot(clean);
title('Input signal');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Zero-initialization of output signal
out = zeros(slen,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% inverzni filtr
H = freqz(b, a, wlen,"whole");
Hinv = freqz(a, b, wlen,"whole");
% Main cycle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:wnum,

  % short-time frame selection
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  ii=(i-1)*wstep+1;
  jj=(i-1)*wstep+wlen;

  frame=sig(ii:jj).*w;
  frame_clean = clean(ii:jj).*w;
  
  % No modification
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % yframe = frame ;

  % WF filtrace
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Gx = abs(fft(frame)).^2/wlen;
    %Gclean = abs(fft(frame_clean)).^2/wlen;
    Gclean = Gx - Sn;
    Hwf = (Hinv).*(abs(H).^2)./((abs(H).^2)+(Sn./(max(Gclean,0))));
    X = fft(frame);



  
  Y = Hwf.*X;
  yframe = ifft(Y);
  
  % Addition to output signal (implementation of OLA with general window)
  out(ii:jj)=out(ii:jj)+yframe;

end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normalization of output signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

scale2 = sum ( w(1:wstep:wlen) ) ;
out = out ./ scale2 ;

subplot(212);
plot(out) ;
title('Output signal');

%SNR
%%%%%%%%%%%%%%%%%%%%%%

N = out - clean;
SNR = 10*log10(mean(out(512:end-512).^2)/mean(N(512:end-512).^2))


sound(clean, 16000)
sound(out, 16000)

