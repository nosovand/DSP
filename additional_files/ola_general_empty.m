% EXAMPLE OF OLA-GENERAL IMPLEMENTATION 
%  (without any modification)

addpath H:\VYUKA\DSP\m
addpath H:\VYUKA\DSP\signaly

% addpath /home/pollak/www/html/vyu/b2m31dsp/m
% addpath /home/pollak/www/html/vyu/b2m31dsp/signaly

% Loading of clean signal
%%%%%%%%%%%%%%%%%%%%%%%%%

load sink.mat;
clean = sum(sink(1:3,:));

clean = clean(:); %zmena na sloupcovy vektor

sig=clean;

%Loading of noise
%%%%%%%%%%%%%%%%%%%%
K = 0.3;
noise = loadbin('nc2.bin');
noise = K*noise(1:length(sig));
sig = sig + noise;

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

% jednotlive casti WF
%%%%%%%%%%%%%%%%%%%%%%%
Ss = myPwelch(clean,wlen,wstep);
Sn = myPwelch(noise,wlen,wstep);

%celkovy WF
%%%%%%%%%%%%%%%%%%%%%%%
Hwf = Ss./(Ss+Sn);

% Vykresleni vstupniho signalu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1); clf ;
subplot(211);
plot(sig);
title('Input signal');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Zero-initialization of output signal
out = zeros(slen,1);

% Main cycle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:wnum,

  % short-time frame selection
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  ii=(i-1)*wstep+1;
  jj=(i-1)*wstep+wlen;

  frame=sig(ii:jj).*w;
  
  % No modification
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % yframe = frame ;

  % WF filtrace
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  F = fft(frame,wlen);
  FY = F.*Hwf;
  yframe = ifft(FY,wlen);
  
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

