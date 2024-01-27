close all; clear; clc
Fs = 100;
t = -1 : 1/Fs : 1;
x = 1 .* (t>=-0.5 & t<=0.5);
a0 = 1;
XT = a0/2*ones(size(t));
for n=1:100
    an = 2*sin(0.5*n*pi)/(n*pi);
    XT = XT + an*cos(n*pi*t);
end
plot(t,x,'.g',t,XT,'r');
ylim([-0.5,1.5])

%% 
close all; clear; clc
Fs = 100;
t = -2 : 1/Fs : 2;
x = (1-abs(t)).*(t>=-1 & t<=1);
a0 = 1/2;
XT = a0/2 * ones(size(t));
for n=1:100
    an = -(4*cos(n*pi/2)-4)/(pi.*pi.*n.*n);
    XT = XT + an.*cos(n*pi.*t/2);
end
plot(t,x,'.g',t,XT,'r')
ylim([-0.5,1.5])

%% 
close all; clear; clc
Fs = 100;
t = -pi : 1/Fs : pi;
x = t .*(t>=0);
a0 = pi/2;
XT = a0/2 * ones(size(t));
for n=1:100
    an = (cos(-n*pi)-1)/(n*n*pi);
     bn = -cos(n*pi)/n;
    XT = XT + an.*cos(n*t)+bn.*sin(n*t);
end
plot(t,x,'.g',t,XT,'r');
ylim([-0.5,pi+0.5])

%% 
close all; clear; clc
Fs = 100;
t = -pi : 1/Fs : pi;
x = t.^2;
a0 = 2*pi*pi/3;
XT = a0/2 * ones(size(t));
for n=1:100
    %an = (1/pi).*(  (pi*pi*sin(pi*n)/n) + (2*pi*cos(n*pi)/(n*n)) + (2*sin(pi*n)/(n^3)) - (pi*pi*sin(-pi*n)/2) + (2*pi*cos(pi*n)/(n*n)) + (2*sin(-n*pi)/(n^3))  );
    %an = (1/pi).*(  2*pi*pi*sin(pi*n)/n + 4*pi*cos(pi*n)/(n^2)  )
    %an = 2*pi*sin(pi*n)/n + 4*cos(pi*n)/(n^2);
    an = 4*cos(pi*n)/(n^2);
    XT = XT + an.*cos(n*t);
end
plot(t,x,'g',t,XT,'r')

%% 
close all; clear; clc
Fs = 100;
t = -2 : 1/Fs : 4;
x = ((-(t.^2)/2) +1) .* (t<=0) + (((t.^2)/2)+1) .* (t>0 & t<=2) + 1.*(t>2);
a0 = 2;
XT = a0/2 * ones(size(t));
for n=1:100
    an = (18*(cos(2*n*pi/3)-1)/(n*n*n*pi*pi*pi)) + (12*sin(2*n*pi/3)/(n*n*pi*pi)) - (4*cos(2*n*pi/3)/(n*pi));
    XT = XT + an.*(sin((n*pi.*t)/3));
end
plot(t,x,'.g',t,XT,'r')

%% 
close all; clear; clc
Fs = 100;
t = -5 : 1/Fs : 5;
x = -1*(1.*(t>=-5&t<-4)-1.*(t>=-4&t<-3)+1.*(t>=-3&t<-2)-1.*(t>=-2&t<-1)+1.*(t>=-1&t<0)-1.*(t>=0&t<1)+1.*(t>=1&t<2)-1.*(t>=2&t<3)+1.*(t>=3&t<4)-1.*(t>=4&t<5));
XT = zeros(size(t));
for n=1:100
    bn = (1-cos(n*pi))/(n*pi);
    bn = 2*(1-(-1)^n)/(n*pi);
    XT = XT + bn.*sin(n*pi.*t);
end
plot(t,x,'g',t,XT,'r');
ylim([-1.5,1.5]);

%%
close all; clear; clc
Fs = 100;
t = -4 : 1/Fs : 4;
x = sign(t).*2.*(1-abs(t)/2).*(t>=-2 & t<=2);
XT = zeros(size(t));
for n=1:100
    bn = (-8*sin(n*pi/2))/(n*n*pi*pi) + 4/(n*pi);
    XT = XT + bn*sin(n*pi*t/4);
end
plot(t,x,'.g',t,XT,'r');


