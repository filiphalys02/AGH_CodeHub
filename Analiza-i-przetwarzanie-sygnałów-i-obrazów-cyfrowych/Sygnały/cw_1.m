close all; clear; clc
Fs = 50;
t = 0 : 1/Fs : 10;
x = 2 .* (t>=3 & t<=6);
plot(t,x);
ylim([-0.5,2.5]);
srednia = mean(x)
Eciagla = sum(x.^2)/Fs
Edyskre = sum(x.^2)

%%
close all; clear; clc
Fs = 50;
t = 0 : 1/Fs : 10;
x = 2*(1-2*abs(t-5)/8) .* (t>=1 & t<=9);
plot(t,x);
ylim([-0.5,2.5]);
srednia = mean(x)
Eciagla = sum(x.^2)/Fs
Edyskre = sum(x.^2)

%%
close all; clear; clc
Fs = 50;
t = 0 : 1/Fs : 10;
x = (3-i).*(t>=0 & t<=10);
plot(t,real(x),'g',t,imag(x),'r');
ylim([-1.5,3.5])
srednia = mean(x)
Eciagla = sum(x.^2)/Fs
Edyskre = sum(x.^2)

%%
close all; clear; clc
Fs = 50;
t = 0 : 1/Fs : 10;
x = 1.*(t>=5).*sin(2*pi.*t);
plot(t,x);
srednia = mean(x)
Eciagla = sum(x.^2)/Fs

%% 
close all; clear; clc
Fs = 50;
t = 0 : 1/Fs : 10;
x = 2*exp((-(t-4).^2/(2*0.5*0.5)));
plot(t,x);
srednia = mean(x)
Eciagla = sum(x.^2)/Fs
Edyskre = sum(x.^2)

%%
close all; clear; clc
Fs = 50;
t = 0 : 1/Fs : pi/4;
x = sin(2*t) + i*cos(2*t);
plot(t,real(x),'g',t,imag(x),'r');
srednia = mean(x)
Eciagla = sum(x.^2)/Fs

%%
close all; clear; clc
Fs = 50;
t = 0 : 1/Fs : 10;
x = 2*t - 1;
plot(t,x);
srednia = mean(x)
Eciagla = sum(x.^2)/Fs
Eciagla = sum(x.^2)

%%
close all; clear; clc
Fs = 50;
t = 0 : 1/Fs : 10;
x = (3-4i) .* (t<=5);
plot(t,real(x),'g',t,imag(x),'r');
ylim([-4.5,3.5]);
srednia = mean(x)
Eciagla = sum(x.^2)/Fs
Edyskre = sum(x.^2)

%%
close all; clear; clc
x = [-1,0,2,-4];
y = [2,0,1];
splot = conv(x,y)
korel = xcorr(x,y)

%%
close all; clear; clc
x = [1,3,3,3,2,2];
y = [-1,0,1];
splot = conv(x,y)
korel = xcorr(x,y)

%%
close all; clear; clc
x = [0,0,1,0,0];
y = [0.25,0.5,0.25];
splot = conv(x,y)
korel = xcorr(x,y)

%%
close all; clear; clc
x = [1+1i,1-1i,0,i,4];
y = [1,1+1i,-2];
splot = conv(x,y)
korel = xcorr(x,y)

%%
close all; clear; clc
Fs = 50;
t = -5 : 1/Fs : 10;
x = exp((-t.^2)/(2*0.2*0.2));
y = (mod(t,0.1)==0);
splot = conv(x,y)
plot(t,x,'g',t,y,'r');

%%
close all; clear; clc
Fs = 100;
t1 = 0 : 1/Fs : 10;
t2 = 0 : 1/Fs : 0.2;
f = 1 * sin(2*pi*t1/0.5);
g = (1./(t2*100)).*(t2<=0.2);
plot(t1,f,'g',t2,g,'r');
splot = conv(f,g)



