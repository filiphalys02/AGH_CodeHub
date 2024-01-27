close all; clear; clc

% ciagla tarnsformata Fouriera
% dane: t: <0,20>, Fs = 100
% x - suma skladowych x1,x2,x3
% x1 = harmoniczna,

Fs = 100;
t = 0 : 1/Fs : 20;

x1 = sin(2*pi*t*(1000/45));
x2 = 2 * exp( (-(t-8).*(t-8)) / (2*2*2) );
x3 = 0.9 * sin(2*pi*t*13);

x = x1 + x2 + x3;

XT = fftshift(fft(x));
WA = abs(XT);
f = linspace(-Fs/2, Fs/2, length(t));
subplot(211), plot(t,x); 
subplot(212), plot(f,WA);

%%
close all; clear; clc
x = [1 2+1i 3-1i 1];
fft(x)

%%
close all; clear; clc

% t=<0,20>, Fs=100
% x-suma skladowych
% x1-prostokat, sr=10, szer=8s, A=1
% x2-harmoniczna, A=0.25, f=15Hz
% x3-harmoniczna, A=0.5, f=21Hz

Fs = 100;
t = 0 : 1/Fs : 20;

x1 = 1*(t>=6 & t<=14);
x2 = 0.25 * sin(2*pi*t*15);
x3 = 0.5 * sin(2*pi*t*21);

x = x1 + x2 + x3;

XT = fftshift(fft(x));
WA = abs(XT);
f = linspace(-Fs/2, Fs/2, length(t));
subplot(211), plot(t,x); 
subplot(212), plot(f,WA);


%%
close all; clear; clc
% t=<0,20>, Fs=100
% x-suma skladowych
% x1-prostokat, sr=10, szer=8s, A=1
% x2-harmoniczna, A=0.25, f=15Hz
% x3-harmoniczna, A=0.5, f=21Hz

Fs = 100;
t = 0 : 1/Fs : 20;

x1 = 1*(t>=6 & t<=14);
x2 = 0.25 * sin(2*pi*t*15);
x3 = 0.5 * sin(2*pi*t*21);

x = x1 + x2 + x3;

XT = fftshift(fft(x));
WA = abs(XT);
f = linspace(-Fs/2, Fs/2, length(t));

% filtr dolnoprzepustowy o szerokości odcięcia 10 Hz
LP = 1.0*(abs(f)<10);
% filtr górnoprzepustowy o szerokości odcięcia 10 Hz
HP = 1.0*(abs(f)>10);
% suma logiczna dwoch filtrow
BS = 1.0*(abs(f)<10) | 1.0*(abs(f)>18);
xn = real(ifft(ifftshift(XT .* BS)));
subplot(211), plot(t,x,'g',t,xn,'k'); 
subplot(212), plot(f,WA,'g',f,500*BS,'r');
 
%%
close all; clear; clc

Fs = 100;
t = 0 : 1/Fs : 20;

x1 = 1*(t>=6 & t<=14);
x2 = 0.25 * sin(2*pi*t*15);
x3 = 0.5 * sin(2*pi*t*21);

x = x1 + x2 + x3;

XT = fftshift(fft(x));
WA = abs(XT);
f = linspace(-Fs/2, Fs/2, length(t));
% rozwiaz filtr dolnoprzepustowy Butterwortha: f0=10, N=3
% LPB = 1.0 ./ (1+(f/f0).^(2*N));
% LPB = 1.0 ./ (1+(f/10).^(2*3));

% rozwiaz filtr dolnoprzepustowy Butterwortha: f0=8, N=4
LPB = 1.0 ./ (1+(f/8).^(2*4));

xn = real(ifft(ifftshift(XT .* LPB)));
subplot(211), plot(t,x,'g',t,xn,'k'); 
subplot(212), plot(f,WA,'g',f,500*LPB,'r');

%%
close all; clear; clc

Fs = 100;
t = 0 : 1/Fs : 20;

x1 = 1*(t>=6 & t<=14);
x2 = 0.25 * sin(2*pi*t*15);
x3 = 0.5 * sin(2*pi*t*21);

x = x1 + x2 + x3;

XT = fftshift(fft(x));
WA = abs(XT);
f = linspace(-Fs/2, Fs/2, length(t));

% rozwiaz filtr dolnoprzepustowy Butterwortha: W=5, N=4, f0=15
f0=15;
W=5;
N=4;
BS = 1.0 ./ (1+( f.*W./(f.^2-f0^2)).^(2*N))

xn = real(ifft(ifftshift(XT .* BS)));
subplot(211), plot(t,x,'g',t,xn,'k'); 
subplot(212), plot(f,WA,'g',f,500*BS,'r');

%%
close all; clear; clc

Fs = 100;
t = 0 : 1/Fs : 20;

x1 = 1*(t>=6 & t<=14);
x2 = 0.25 * sin(2*pi*t*15);
x3 = 0.5 * sin(2*pi*t*21);

x = x1 + x2 + x3;

XT = fftshift(fft(x));
WA = abs(XT);
f = linspace(-Fs/2, Fs/2, length(t));

% rozwiaz filtr dolnoprzepustowy Gaussa: f0=4
f0=4;
LPG = exp(-f.*f/(2*f0^2));

xn = real(ifft(ifftshift(XT .* LPG)));
subplot(211), plot(t,x,'g',t,xn,'k'); 
subplot(212), plot(f,WA,'g',f,500*LPG,'r');