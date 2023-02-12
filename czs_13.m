%% HT - Speech signal

% xs=loadbin('SA106S06.CS0') ;
% xs=xs(14001:21000);
% savebin('../signaly/speech_16k_HT.cs0',xs);

xs=loadbin('speech_16k_HT.cs0') ;

N=length(xs);

nn=0:N-1;


[xh]=hilbert(xs);

xhr=real(xh);
xhi=imag(xh);
obalka=sqrt(xhr.^2+xhi.^2);

xe=abs(xs).^2;
xee=abs(xs);

M=30;
xap=filter([ones(1,M+1)/(M+1)],1,xe);

figure(1)
subplot(311)
plot(xs)
title('Signal - speech')
subplot(312)
plot(nn,xs,'b',nn,xhi,'b:',nn,obalka,'r--',nn,-obalka,'r--')
title('Hilbert envelope')
subplot(313)
%plot(nn,x,nn,(xap))
plot(nn,xs,'b',nn,sqrt(2*xap),'r--',nn,-sqrt(2*xap),'r--')
title('MA envelope')


%% HT sinusoid - constant amplitude

N=100;
nn=0:N-1;

fs=500;
f=50;
x=sin(2*pi*f/fs*nn);

[xh]=hilbert(x);

xhr=real(xh);
xhi=imag(xh);
obalka=sqrt(xhr.^2+xhi.^2);

xe=abs(x).^2;
xee=abs(x);

M=30;
xap=filter([ones(1,M+1)/(M+1)],1,xe);
figure(2)
subplot(311)
plot(x)
title('Signal - sinusoid with constant amplitude')
subplot(312)
plot(nn,x,'b',nn,xhi,'b:',nn,obalka,'r--',nn,-obalka,'r--')
title('Hilbert envelope')
subplot(313)
%plot(nn,x,nn,(xap))
plot(nn,x,'b',nn,sqrt(2*xap),'r--',nn,-sqrt(2*xap),'r--')
title('MA envelope')



%% HT modulated sinusoid (exponencial amplitude)

N=100;
nn=0:N-1;


x=.95.^nn.*sin(2*pi*50/500*nn);

[xh]=hilbert(x);

xhr=real(xh);
xhi=imag(xh);
obalka=sqrt(xhr.^2+xhi.^2);

xe=abs(x).^2;
xee=abs(x);

M=30;
xap=filter([ones(1,M+1)/(M+1)],1,xe);
figure(3)
subplot(311)
plot(x)
title('Signal - sinusoid with exponential amplitude (modulated)')
subplot(312)
plot(nn,x,'b',nn,xhi,'b:',nn,obalka,'r--',nn,-obalka,'r--')
title('Hilbert envelope')
subplot(313)
%plot(nn,x,nn,(xap))
plot(nn,x,'b',nn,sqrt(2*xap),'r--',nn,-sqrt(2*xap),'r--')
title('MA envelope')



%% HT - recovy signal modulovany na sinu

% xsr=xs(3001:4000);
% savebin('../signaly/speech_16k_HT_frame.cs0',xsr);

xsr=loadbin('../signaly/speech_16k_HT_frame.cs0');


fsr=16000;

Nr=length(xsr);
nnr=0:Nr-1;
ttr=nnr./fsr;

fsa=8*fsr;

xsa=resample(xsr,fsa,fsr);

tta=(0:length(xsa)-1)./fsa;
fsn=fsa/5;
nosna=sin(2*pi*fsn*tta);
nosna=nosna(:);

k=0.8;
prenos=nosna.*(1+k*xsa);

[xh]=hilbert(prenos);

xhr=real(xh);
xhi=imag(xh);
obalka=sqrt(xhr.^2+xhi.^2);

xsr_obalka=decimate(obalka,fsa/fsr);
xsr_obalka=(xsr_obalka-1)./k;


figure(10)
subplot(311)
plot(ttr,xsr)
title('LF signal')
subplot(312)
plot(tta,nosna)
title('HF carrier signal')
subplot(313)
plot(tta,prenos)
title('AM modulated signal')


figure(11)
subplot(311)
plot(ttr,xsr)
title('Original LF signal')
subplot(312)
plot(tta,prenos,'b',tta,obalka,'r')
title('AM modulated signal + Hilbert envelope')
subplot(313)
plot(ttr,xsr_obalka,'r',ttr,xsr,'b--')
title('LF signal - demodulated + original')
% plot(tta,(obalka-1)./k,'r',tta,xsa,'b--')
% title('HF useful signal - demodulated + original')

figure(12); 
subplot(221)
Nr=length(xsr);
ffr=(0:Nr-1)./Nr.*fsr;
semilogy(ffr,abs(fft(xsr)))
xlim([0 max(ffr)])
title('Magnitude spectrum of LF signal')
xlabel('Frequency [Hz]')
subplot(222); 
Na=length(prenos);
ffa=(0:Na-1)./Na.*fsa;
semilogy(ffa,abs(fft(xsa)))
xlim([0 max(ffa)])
title('Magnitude spectrum of upsampled LF signal')
xlabel('Frequency [Hz]')
subplot(223); 
Na=length(prenos);
ffa=(0:Na-1)./Na.*fsa;
semilogy(ffa,abs(fft(nosna)))
xlim([0 max(ffa)])
title('Magnitude spectrum of HF carrier signal')
xlabel('Frequency [Hz]')
subplot(224); 
Na=length(prenos);
ffa=(0:Na-1)./Na.*fsa;
semilogy(ffa,abs(fft(prenos)))
xlim([0 max(ffa)])
title('Magnitude spectrum of HF modulated signal')
xlabel('Frequency [Hz]')

