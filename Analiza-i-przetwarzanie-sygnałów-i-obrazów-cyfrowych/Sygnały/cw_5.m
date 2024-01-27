%% ZAD 1
close all; clear; clc;
Fs = 100;
t = 0 : 1/Fs : 10;
x1 = 5.*sin(2*pi*t*10);
x2 = 1.*sin(2*pi*t*30);
x=x1+x2
XT = fftshift(fft(x));
WA = abs(XT);
f = linspace(-Fs/2,Fs/2,length(t));
W=2;
BS = 1.0 ./ (1+( f.*W./(f.^2-30^2)).^8)
subplot(211), plot(t,x)
subplot(212), plot(f,WA,'g',f,BS*Fs*5,'r')

%% ZAD 2 
close all; clear; clc;
Fs = 100;
t = 0 : 1/Fs : 10;
x = 1.*(t>=4.5 & t<=5.5);
XT = fftshift(fft(x));
WA = abs(XT);
f = linspace(-Fs/2,Fs/2,length(t));
DP = 1.0 .* (abs(f) <= 10);
GP = 1-(1.0 .* (abs(f) <= 5));
xn = real(ifft(ifftshift(XT.*GP)))
subplot(211), plot(t,x,'g',t,xn,'r');
subplot(212), plot(f,WA,'g',f,GP*Fs,'r');

%% ZAD 3
close all; clear; clc;
Fs = 50;
t = 0 : 1/Fs : 10;
x = 3.*(t>=3 & t<=7);
XT = fftshift(fft(x));
WA = abs(x);
f = linspace(-Fs/2,Fs/2,length(t));
f0=2;
N = 1
BLP = 1 ./ (1+(f/f0).^(2*N))
xn = real(ifft(ifftshift(XT.*BLP)));
subplot(211), plot(t,x,'g',t,xn,'r');
subplot(212), plot(f,WA,'g',f,BLP,'r');

%% ZAD 5
close all; clear; clc;
Fs = 1/0.25
dane = load("trasa_01.txt");
x = dane(:,1)';
t = (0 : 1 : length(x)-1)/4;
XT = fftshift(fft(x));
WA = abs(XT);
f = linspace(-Fs/2,Fs/2,length(t));
LP = 1.0*(abs(f)<0.54);
xod = real(ifft(ifftshift(XT.*LP)))
subplot(211),plot(t,x,'g',t,xod,'r');
subplot(212),plot(f,WA,'g',f,LP*2000000,'r')

%% ZAD 6
close all; clear; clc;
Fs = 1/0.25;
dane = load("trasa_01.txt");
x = dane(:,1)';
t = (0 : 1 : length(x)-1)/4;
XT = fftshift(fft(x));
WA = abs(XT);
f = linspace(-Fs/2,Fs/2,length(t));
BW = 1.0*(abs(f)<0.54 & abs(f)>0.05);
xod = real(ifft(ifftshift(XT.*BW)));
subplot(211),plot(t,x,'g',t,xod,'r');
subplot(212),plot(f,WA,'g',f,BW*2000000,'r');

%% ZAD 8
close all; clear; clc;
Fs = 100
t = 0 : 1/Fs : 10;
x1 = 1.0*sin(2*pi*t*10) + 0.5*sin(2*pi*t*3.75) + 0.75*sin(2*pi*t*18) + (0.02*randn(1,length(t))-0.01);
x2 = 1.0*sin(2*pi*t*10).*(t<3) + 0.5*sin(2*pi*t*3.75).*(t<6&t>3) + 0.75*sin(2*pi*t*18).*(t>6&t<9) + (0.02*randn(1,length(t))-0.01);
x3 = 1.0*sin(2*pi*t.*(9*t/20+0.5));
x4 = 1.0*sin(2*pi*t*5).*(t>7) + 1.0*sin(2*pi*t*5).*(t<4) + 1.0*sin(2*pi*t*5).*(t>4&t<7)
f = linspace(-Fs/2,Fs/2,length(t));
WA1 = abs(fftshift(fft(x1)));
WA2 = abs(fftshift(fft(x2)));
WA3 = abs(fftshift(fft(x3)));
WA4 = abs(fftshift(fft(x4)));
figure;
subplot(221),plot(t,x1);
subplot(222),plot(t,x2);
subplot(223),plot(t,x3);
subplot(224),plot(t,x4);
figure;
subplot(221),plot(f,WA1);
subplot(222),plot(f,WA2);
subplot(223),plot(f,WA3);
subplot(224),plot(f,WA4);