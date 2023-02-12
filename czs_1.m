% c1

A=1;
f=2123;
fs=8000;
to=0.1;

tt=0:1/fs:to-1/fs;
s=A*sin(2*pi*f*tt);

figure(1)
plot(tt,s,'g.-')
title('sin - waveform')
xlabel('Time - t[s]')
ylabel('s(t)')

% nahodne signaly

N=10000;

n1=rand(1,N);
n2=randn(1,N);

figure(2)
subplot(211)
plot(n1)
title('uniform distribution')
subplot(212)
plot(n2)
title('gauss')

figure(3)
subplot(211)
histogram(n1, 30)
title('uniform distribution')
subplot(212)
histogram(n2,40)
title('gauss')

mean_n1=mean(n1)
mean_n2=mean(n2)

%vykon

Pn1 = mean(n1.^2) % . - prvek po prvku a ne cela matice
Pn1 = mean(n2.*n2)
Ps=mean(s.^2)

var_n1=var(n1)
var_n2=var(n2)

new_var=0.1;
n22=sqrt(new_var)*n2

figure(4)

subplot(212)
histogram(n22,40)
title('gauss mod var')

figure(5)
plot(n2)
hold on
plot(n22)
hold off