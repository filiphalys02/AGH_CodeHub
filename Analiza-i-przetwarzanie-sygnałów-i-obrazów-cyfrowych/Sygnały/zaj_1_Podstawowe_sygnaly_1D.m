close all; clear; clc;

%   S Y G N A Ł   P R O S T O K Ą T N Y
% t0=0, ta=3, tb=6, tk = 9, A=2

Fs = 10;
t = 0 : 1/Fs : 9;
x = 2*(t>=3 & t<=6);
plot(t,x);
ylim([-0.5, 2.5]);
srednia = mean(x)
E_ciagla = sum(x.^2)/Fs
E_dyskre = sum(x.^2)

%%
close all; clear; clc;

%   S Y G N A Ł   T R Ó J K Ą T N Y
% t0=-4, ta=-2, tw=0, tb=2, tk=4, A=3

Fs = 10;
t = -4 : 1/Fs : 4;
x = 3*(1-abs(t)/2) .* (t>=-2 &t<=2);
plot(t,x);
ylim([-0.5, 3.5]);
srednia = mean(x)
E_ciagla = sum(x.*x)/Fs
E_dyskre = sum(x.*x)

%%
close all; clear; clc;

%   S Y G N A Ł   H A R M O N I C Z N Y
% t0=-5, tk=2*pi

Fs = 100
t = [-5 : 1/Fs : 2*pi]
x = (2+t/5).*sin(2*pi*10*t);
plot(t,x);

%%
close all; clear; clc;

%   S Y G N A Ł   S I N C

% Problem z dzialaniem funkcji sinc, wiec wygenerowalem sobie wlasna
sinc = @(x) (sin(pi*x)./(pi*x));

Fs = 100;
t = [-5 : 1/Fs : 5];
x = sinc(2*t);
plot(t,x);
ylim([-0.5, 1.5]);


%% 
close all; clear; clc;

%   S Y G N A Ł   G A U S S A

Fs = 100;
odch = 1.5;
sr = 1;
t = [-5 : 1/Fs : 2*pi];
e = exp(1);
x = e * exp((-(t-sr).*(t-sr))/(2*odch.*odch));
plot(t,x);

%% 
close all; clear; clc;

%   F U N K C J A   Z N A K U   ( S I G N )

Fs = 100;
t = [-5 : 1/Fs : 5];
x = sign(t)
plot(t,x);
ylim([-1.5, 1.5]);

%%
close all; clear; clc;

%   F U N K C J A   S T A R T U   ( H E A V I S I D E )

Fs = 100;
t = [-5 : 1/Fs : 5];
x = (t>=0)
plot(t,x);
ylim([-0.5, 1.5]);

%%
close all; clear; clc;

%   F U N K C J A   C H A   ( G R Z E B I E N I O W A )

Fs = 100;
t = [-5 : 1/Fs : 2*pi];
x = (mod(t,0.1)==0);
plot(t,x);
ylim([-.5, 1.5])

%%
close all; clear; clc

% S Y G N A Ł   P O W T Ó R K O W Y   Z   E L E M E N T E M   Z E S P O L O N Y M
% T=<0,2pi>, x(t)=0, dla t=<pi/2,2pi> x(t)=sin(2t)-icos(2t), dla t=<0,pi/2>
% sygnał czerwony - Re, sygnał zespolony - Im

Fs = 10;
t = 0 : 1/Fs : 2*pi;
x = (sin(2*t) - 1i*cos(2*t)).*(t<=pi/2);
plot(t,real(x),'r',t,imag(x),'g');
srednia = mean(x)
E_ciagla = sum(abs(x))/Fs

%%
close all; clear; clc;

% S Y G N A Ł   P O W T Ó R K O W Y   Z   E L E M E N T E M   Z E S P O L O N Y M 
% t=<-3,5>, próbkowanie=20, x(t)=3i * sgn(2t) + 4t * H(2t)
% sygnał czerwony - Re, sygnał zespolony - Im
 
Fs = 20;
t = -3 : 1/Fs : 5;
x = 3i * sign(2*t) + 4*t.*(t>0);
plot(t,real(x), 'r', t, imag(x), 'g');
srednia = mean(x)
E_dyskre = sum(abs(x).^2)