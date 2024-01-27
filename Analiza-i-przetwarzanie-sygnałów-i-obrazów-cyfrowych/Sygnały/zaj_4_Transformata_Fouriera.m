close all; clear; clc;

Fs = 100;
t = -5 : 1/Fs : 5;
x = 4 * (abs(t)<3);
XT = fft(x);
XT = fftshift(XT);
WA = abs(XT); %widmo amplitudowe
WF = angle(XT); %widmo fazowe
%f = linspace(0, Fs, length(t));
f = linspace(-Fs/2, Fs/2, length(t));

subplot(211), plot(t, x);
subplot(212), plot(f, WA);

% wykres widma w funkcji czasu = 0pkt na kolokwium !!!

%%
close all; clear; clc;

sinc = @(x) (sin(pi*x)./(pi*x));


Fs = 100;
t = -5 : 1/Fs : 5;
x = 4 * (abs(t)<3);
XT = fft(x);
XT = fftshift(XT);
WA = abs(XT); %widmo amplitudowe
WF = angle(XT); %widmo fazowe
%f = linspace(0, Fs, length(t));
f = linspace(-Fs/2, Fs/2, length(t));
WA_t = abs(24*sinc(2*3*f)*Fs);

subplot(211), plot(t, x);
subplot(212), plot(f, WA,'r',f, WA_t,'g');

%%
close all; clear; clc

% ciagla tarnsformata Fouriera
% dane: t: <0,20>, Fs = 100
% x - suma skladowych x1,x2,x3
% x1 = harmoniczna,

Fs = 100
t = 0 : 1/Fs : 20;
x1 = sin(2*pi*t*(1000/45));
x2 = 2 * exp( (-(t-8).*(t-8)) / (2*2*2) );
x3 = 0.9 * sin(2*pi*t*13);
x = x1 + x2 + x3;

XT = fftshift(fft(x));
WA = abs(XT);
WF = angle(XT);
f = linspace(-Fs/2,Fs/2,length(t));
subplot(211), plot(t,x,'r');
subplot(212), plot(f,WA,'g');