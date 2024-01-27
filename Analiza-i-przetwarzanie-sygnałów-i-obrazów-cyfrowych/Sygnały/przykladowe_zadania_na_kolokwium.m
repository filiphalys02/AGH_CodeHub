%% ZAD. 1
close all; clear; clc;
% Oblicz średnią i energię sygnałów ciągłego i dyskretnego (w przypadku dyskretnych Fs = 20 Hz).
% x(t) = 1 + 2i · t dla t ∈ <0,5> (ciągły i dyskretny)
Fs = 20;
t = 0 : 1/Fs : 5;
x = 1 + 2*1i*t;
plot(t,real(x),'r',t,imag(x),'g');
srednia = mean(x)
Eciagla = sum(x.^2)/Fs
Edyskre = sum(x.^2)

%% ZAD. 1
close all; clear; clc;
% Oblicz średnią i energię sygnału ciągłego 2sin^2(2t) dla t=<0,pi/4>.
Fs = 20;
t = 0 : 1/Fs : pi/4;
x = 2*(sin(2*t)).^2;
plot(t,x);
srednia = mean(x)
Eciagla = sum(x.^2)/Fs

%% ZAD. 1
close all; clear; clc;
% Oblicz średnią i energię sygnału trójkątnego (tw=5, ta=3, tb=7)(w przypadku dyskretnych Fs = 20 Hz).
% dla t=<0,8> i A=2
Fs = 20;
t = 0 : 1/Fs : 8;
x = 2*(1-abs(t-5)/2) .* (t>=3 & t<=7);
plot(t,x);
ylim([-0.5,2.5]);
srednia = mean(x)
Eciagla = sum(x.*x)/Fs
Edyskre = sum(x.*x)
    
%% ZAD. 2
close all; clear; clc;
% Rozwiń w szereg Fouriera sygnał
% x = 2t dla t ∈< 0, 1), x = 2 dla t ∈< 1, 3), x = 0 dla t ∈< 3, 6)
Fs = 20;
t = 0 : 1/Fs : 6;
x = 2*t.*(t<1) + 2*(t>=1 & t<3);
a0 = 5/6;
XT = a0 * ones(size(t));
for n=1:100
    an = 6*cos(n*pi/3)/(pi*pi*n*n) - 6/(n*n*pi*pi);
    bn = 6*sin(n*pi/3)/(pi*pi*n*n) - 2*cos(n*pi)/(n*pi);
    XT = XT + an*cos(n*pi*t/3) + bn*sin(n*pi*t/3);
end
plot(t,x,'.g',t,XT,'r');
ylim([-0.5,2.5]);

%% ZAD. 2
close all; clear; clc;
% Rozwiń w szereg Fouriera sygnał
Fs = 20;
t = -3 : 1/Fs : 3;
x = (t.*t-1).*sign(t) .* (abs(t)<=3 & abs(t)>=1) + heaviside(t-2).*((t.^2)-1).*(t>-1 & t<1);
XT = zeros(size(t));
for n=1:100
    bn = -16*cos(pi*n)/(pi*n) + 36*cos(n*pi)/(n*n*n*pi*pi*pi) - 12*sin(n*pi/3)/(n*n*pi*pi) - 36*cos(n*pi/3)/(n*n*n*pi*pi*pi);
    XT = XT + bn.*sin(n*pi.*t/3);
end
plot(t,x,'.g',t,XT,'r');

%% Żle
close all; clear; clc;
% Rozwiń w szereg Fouriera sygnał
Fs = 20;
t = -1 : 1/Fs : 3;
x = (-2*t-1).*(t<0) -1.*(t>=0&t<=1) +(t-2).*(t>1);
XT = -1/2 * ones(size(t));
for n=1:100
    an = 2*(-2+cos(n*pi/2)+cos(3*n*pi/2))/(n*n*pi*pi);
    bn = -6*sin(n*pi/2)/(n*n*pi*pi) + 2*sin(3*n*pi/2)/(n*n*pi*pi) + 3*cos(3*n*pi/2)/(pi*n) + 2*cos(3*n*pi/2)/(pi*n) + cos(n*pi/2)/(n*pi);
    XT = XT + an*cos(n*pi*t/2)+bn*sin(n*pi*t/2);
end
plot(t,x,'.g',t,XT,'r')
ylim([-1.5,1.5])

%% ZAD. 2
close all; clear; clc;
Fs = 20;
t = -4 : 1/Fs : 4;
x = sign(2*t).*(t.^2);
XT = zeros(size(t));
for n=1:100
    bn = -64/(n*n*n*pi*pi*pi);
    bn = -32*cos(pi*n)/(pi*n) + 64*cos(pi*n)/(pi*pi*pi*n*n*n) - 64/(pi*pi*pi*n*n*n);
    XT = XT + bn*sin(n*pi*t/4);
end
plot(t,x,'.g',t,XT,'r');

%% ZAD. 2
close all; clear; clc;
Fs = 20;
t = -2 : 1/Fs : 4;
x = heaviside(-2*t).*t.*t;
XT = 4*ones(size(t))/9
for n=1:100
    an = 4*sin(2*n*pi/3)/(n*pi) + 12*cos(2*n*pi/3)/(n*n*pi*pi) - 18*sin(2*n*pi/3)/(n*n*n*pi*pi*pi);
    bn = 18/(n*n*n*pi*pi*pi) + 4*cos(2*n*pi/3)/(n*pi) - 12*sin(2*n*pi/3)/(n*n*pi*pi) - 18*cos(2*n*pi/3)/(n*n*n*pi*pi*pi);
    XT = XT + an*cos(n*pi*t/3) + bn*sin(n*pi*t/3);
end
plot(t,x,'.g',t,XT,'r');

%% ZAD. 2 Źle
close all; clear; clc;
Fs = 20;
t = -2 : 1/Fs : 4;
x = (t+1).*(t>=-1 & t<0) + (1/2).*(t==0);
%XT = ones(size(t))/4;
%for n=1:100
%    an = 4/(9*n*n*pi*pi) - 4*cos(3*n*pi/2)/(9*n*n*pi*pi);
%    bn = 4*sin(3*n*pi/2)/(9*n*n*pi*pi) - 2/(3*n*pi)
%    XT = XT + an*cos(n*pi*t/3) + bn*sin(n*pi*t/3);
%end
XT = 0.5*ones(size(t));
for n=1:100
    bn = 9*sin(n*pi/3)/(2*pi*pi*n*n) + 3*cos(n*pi/3)/(n*pi);
    XT = XT + bn*sin(n*pi*(t-0.5)/3);
end
plot(t,x,'.g',t,XT,'r');

%% ZAD. 3
close all;clear;clc;
x1 = [1+i, 1-i, -1+i, -1-i];
y1 = [1, 2-i, 2+i];
x2 = [3-i, 3, -2i, 3+i];
y2= [ 2+2i, 2-2i, 2i];
x3 = [2-i, 3+4i, -12i, -2i];
y3= [ 1-2i, 1+2i, -3i];
splot1 = conv(x1,y1);
korel1 = xcorr(x1,y1)
splot2 = conv(x2,y2);
korel2 = xcorr(x2,y2)
splot3 = conv(x3,y3);
korel3 = xcorr(x3,y3)

%% ZAD. 4
close all; clear; clc;
dane = load('testowe.dat.txt');
t = dane(:,1);
x = dane(:,2);
dt = t(2)-t(1);
t2 = 0 : dt : 2.5;
x2 = 1*(1-abs(t2-1.25)/1.25);
xc = xcorr(x,x2);
tc = (-length(dane)+1 : length(dane)-1)/(1/dt);
nr = find(xc == max(xc(:)),1,'first')
tc(nr)
subplot(211),plot(t,x,'g',t2,x2,'r');
subplot(212),plot(tc,xc);

%% ZAD. 5
close all; clear; clc;
x1 = [1+i, 1-i, -1+i, -1-i];
x2 = [3-i, 3, -2i, 3+i];
x3 = [2-i, 3+4i, -12i, -2i];
XT1 = fftshift(fft(x1));
WA1 = abs(XT1);
XT2 = fftshift(fft(x2));
WA2 = abs(XT2);
XT3 = fftshift(fft(x3));
WA3 = abs(XT3);

%% ZAD. 6
Fs = 25;
t = 0 : 1/Fs : 50;
x1 = (1/1).*sin(2*pi*t*1);
x2 = (1/3).*sin(2*pi*t*3);
x3 = (1/5).*sin(2*pi*t*5);
x = x1+x2+x3;
XT = fftshift(fft(x));
WA = abs(XT);
W = 1;
f = linspace(-Fs/2,Fs/2,length(x));
BW = 1./(1+(f.*W./(f.^2-9)).^16);
xod = real(ifft(ifftshift(XT.*BW)))
subplot(211),plot(t,x,'g',t,xod,'r')
subplot(212),plot(f,WA,'g',f,BW.*Fs,'r')

%% ZAD. 7 
Fs = 50;
t = 0 : 1/Fs : 20;
x1 = 1.5.*(1-abs(t-3)/2).*(t>=1 & t<=5);
x2 = 1.*(t>=6 & t<=8);
x3 = 0.1.*sin(2*pi*t*17);
x4 = 0.75.*sin(2*pi*t.*(-t+21)).*(t>=10);
x = x1+x2+x3+x4;
XT = fftshift(fft(x));
WA = abs(XT);
f = linspace(-Fs/2,Fs/2,length(t));
W = 1;
BP = 1./(1+(f.*W./(f.*f-17*17)).^2)
xod = real(ifft(ifftshift(XT.*BP)))
subplot(211), plot(t,x,'g',t,xod,'r');
subplot(212), plot(f,WA,'g',f,BP*Fs,'r');

%% ZAD. 8
close all; clear; clc;
Fs = 30;
t = 0 : 1/Fs : 10;
x = 2.*(1-abs(t-3)/3).*(t>=0 & t<=6);
srednia = mean(x);
plot(t,x)

%% ZAD. 9
close all; clear; clc;
dane = load("dem_201.txt");
x1 = dane(:,1)';
x2 = dane(:,2)';
Fs = 500;
t = (0 : length(x1)-1)/Fs;
N = 50;
%aaa = fspecial('gaussian',[1 N],N/8)
%aaa = ones(1,N)/N;
%y = conv(x2,aaa,'same');
%y = medfilt1(x2,28); % 0.5536
%y = wiener2(x2, [2 16]); lipny
%y = sgolayfilt(x2,7,117) % 0.4876
%y = sgolayfilt(sgolayfilt(x2,5,81),5,71) %0.4782
y = medfilt1(sgolayfilt(x2,5,81),40) % 0.4552
%y = medfilt1(sgolayfilt(x2,5,81),30) % 0.4578
%y = medfilt1(sgolayfilt(x2,3,39),30) % 0.4755
L2 = @(x,y)sqrt(sum((x(:)-y(:)).^2)/length(x1));
L2(x1,y)
plot(t,x2,'r',t,x1,'g');

%% ZAD. 10
close all; clear; clc;
Fs = 200;
t = -2 : 1/Fs : 4;
x = heaviside(t).*(t.*t);
XT = fftshift(fft(x));
WA = abs(XT);
f = linspace(-Fs/2,Fs/2, length(t));
subplot(211), plot(t,x);
subplot(212), plot(f,WA);

%% ZAD. 12 
close all; clear; clc;
Fs = 100;
t = -5 : 1/Fs : 5;
x = 1.0 * (1-abs(t)/2).*(abs(t)<=2);
XT = fftshift(fft(x))
WA = abs(XT);
f = linspace(-Fs/2,Fs/2,length(t));
subplot(211), plot(t,x);
subplot(212), plot(f,WA);

%% ZAD. 13 
close all; clear; clc;
dane = load("2022_tsd_xcorr2.txt");
x = dane(:,2)';
t = dane(:,1)';
dt = t(2)-t(1);
Fs = 1/dt;
t2 = 0 : dt : 106;
xtroj = 1.4.*(1-abs(t-3)/3).*(t>=0 & t<=6);
xgaus = 1.0.*exp((-(t-10).^2)/(2*9));
tc = (-length(t2)+1 : length(t2)-1)/Fs;
trojkorel = xcorr(x,xtroj);
gauskorel = xcorr(x,xgaus);

p_x = x(6400:8600);
p_t = t(6400:8600);
p_xgauss = 1.0.*exp((-(t-76).^2)/(2*9));
p_xgauss = p_xgauss(6400:8600);
p_xc = xcorr(p_x,p_xgauss);
p_tc = t(6400)+1 : dt/2 : t(8600);
p_nr = find(p_xc==max(p_xc),1,'first');
p_tc(p_nr)+dt

subplot(211), plot(t,x,'g')
subplot(212), plot(tc,trojkorel,'g',tc,gauskorel,'b')

%% ZAD. 3.14
close all; clear; clc;
Fs = 125;
t = -10 : 1/Fs : 15;
x1 = (pi/3)*(1 - abs(t+4)/3.5).*(t>=-7.5 & t<=-0.5);
x2 = 1.25 * exp((-(t-6).^2)/24);
x3 = 0.65 .* sin(2*pi.*(-0.2.*t+5).*t);
x4 = (-0.02*t+0.5).*sin(2*pi*t*17).*(t>=0);
x5 = 0.2*(randn(1,length(t)))-0.1;
x=x1+x2+x3+x4+x5;

XT = fftshift(fft(x));
WA = abs(XT);
f = linspace(-Fs/2,Fs/2,length(t));
f0=17;
W=4;
N=4;
PZB = 1.0 ./ ( 1+( (f.*W)./(f.^2-f0^2)).^(2*N) );
%PZB = 1 - exp((-(abs(f)-17).^2/(2*4)));
PZB =1 - exp(-(abs(f) - 17).^2 /8);
xn = real(ifft(ifftshift(XT.*PZB)));

figure;
subplot(211), plot(t,x,'g',t,xn,'r');
subplot(212), plot(f,WA,'g',f,PZB*Fs*5,'r');
figure;
subplot(221), plot(t,x1);
subplot(222), plot(t,x2);
subplot(223), plot(t,x3);
subplot(224), plot(t,x4);

%% ZAD. 15
close all; clear; clc;
a = load('2022_tsd_hrm1.txt');
x = a(:,1)';
xs= a(:,2)';
Fs = 200;
N = length(x);
t = (0 : 1 : N-1)/Fs ;
y = medfilt1(sgolayfilt(xs,3,53),9) % 0.4308
L2 = @(x,y,N)sqrt(sum((x-y).^2)/N)
plot(t,xs,'r',t,x,'g')
L2(x,y,N)






