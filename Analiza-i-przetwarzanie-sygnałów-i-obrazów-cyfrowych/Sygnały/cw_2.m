%% ZAD. 1 nie rozumiem polecenia
close all; clear; clc;
dane = load("2022_corr_01.txt");
x = dane(:,1);
t = 0 : 1 : length(x)-1;
XT = fftshift(fft(x));
WA = abs(XT);
f = linspace(-length(x)+1,length(x)+1,length(x));
subplot(211),plot(t,x);
subplot(212),plot(f,WA);

%% ZAD. 2
close all; clear; clc;
dane = load("2022_corr_01.txt");
x = dane(:,1);
t = (0 : 1 : length(x)-1)*100000;
XT = fftshift(fft(x));
WA = abs(XT);
N = length(t);
f = linspace(-length(x)+1,length(x)-1,length(x));
aaa = fspecial('gaussian',[1 9],N/20)
y = conv(x,aaa,'same');
subplot(211),plot(t,x);
subplot(212),plot(f,WA,'g',f,y*1000,'r');

%% ZAD. 3 
close all; clear; clc;
Fs = 100;
t = 0 : 1/Fs : 100;
x = 5*sin(2*pi*t*2);
a = 0.5*sin(2*pi*t*60);
b = randn(1,length(t))/2-0.25;
c = rand(1,length(t))*2-1
f = linspace(-Fs/2,Fs/2,length(t));
XTa = fftshift(fft(x+a));
WAa = abs(XTa);
y = sgolayfilt(x+a,3,27)/10;
subplot(211),plot(t,a,'g',t,y,'r')
subplot(212),plot(f,WAa)

%% ZAD. 5
close all; clear; clc;
Fs = 80;
t = 0 : 1/Fs : 10;
x = 1.0*sin(2*pi*t*20)

maska = ones(1,2);
xod = conv(x,maska,'same');
figure;
subplot(211),plot(t,x);
subplot(212),plot(t,xod);

maska = ones(1,4);
xod = conv(x,maska,'same');
figure;
subplot(211),plot(t,x);
subplot(212),plot(t,xod);

maska = ones(1,8);
xod = conv(x,maska,'same');
figure;
subplot(211),plot(t,x);
subplot(212),plot(t,xod);