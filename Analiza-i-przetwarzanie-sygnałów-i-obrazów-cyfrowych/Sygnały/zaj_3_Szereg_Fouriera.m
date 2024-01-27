%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! SZEREG FOURIERA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

% S Y G N A Ł   P R O S T O K Ą T N Y
% t0=-4, ta=-2, tb=2, tk=4, A=3

close all; clear; clc;
Fs = 100;
t = -4 : 1/Fs : 4;
x = 3 *(abs(t)<=2);
XT = 1.5*ones(size(t));
for n=1:100
    an = 6*sin(n*pi/2)/(n*pi);
    XT = XT + an*cos(n*pi*t/4);
end

plot(t,x,'.g', t, XT, 'r');

%%
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! SZEREG FOURIERA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

% S Y G N A Ł   T R Ó J KĄ T N Y
% t0=-4, ta=-2, tb=2, tk=4, A=2
% x(t) = sgn(t) * sygnał trójkątny (wierzchołek=0, szerokość=4, amp=2)

close all; clear; clc;
Fs = 100;
t = -4 : 1/Fs : 4;
x = sign(t) .* (2*(1-abs(t)/2).*(abs(t)<=2));
XT = zeros(size(t));
for n=1 : 100
    bn = 4/(n*pi)-8*sin(n*pi/2)/(n*n*pi*pi);
    XT = XT + bn*sin(n*pi*t/4);
end
plot(t,x,'.g',t,XT,'r')

%%
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! SZEREG FOURIERA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% x(t)=0, t=<0,2)   ;   x(t) = 1, t=<2,4)   ;   x(t) = 2, t=<4,6>
% t=<0,6>
close all; clear; clc;
Fs = 100;
t = 0 : 1/Fs : 6;
x = (t>=2 & t<4) + 2*(t>=4);
XT = ones(size(t));
for n=1:100
    bn = 2*(cos(2*n*pi/3)-1)/(n*pi);
    XT = XT + bn*sin(n*pi*t/3);
end
plot(t,x,'.g', t, XT, 'r');

%%
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! SZEREG FOURIERA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% x(t)=(t-sign(t))^2 ,1<=|t|<=3   ;   x(t)=2 ,t=(-1,-1)
close all; clear; clc;
Fs = 100;
t = -3 : 1/Fs : 3;
x = 2*(abs(t)<1) + (t-sign(t)).^2.*(abs(t)>=1);
XT = 14*ones(size(t))/9;
for n=1:100
    w=n*pi;
    an = 4*sin(w/3)/w + 24*cos(w)/(w*w) + 36*sin(w/3)/(w^3);
    XT = XT + an*cos(w*t/3);
end
plot(t,x,'.g', t, XT, 'r');

%%
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! SZEREG FOURIERA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% t=<-3,3>
% x(t) = 2                dla:  |t| < 1
% x(t) = (t-sgn(t))^2     dla:  1 <= |t| <= 3
close all; clear; clc;
Fs = 100;
t = -3 : 1/Fs : 3;
x = 2*(abs(t)<1) + (t-sign(t)).^2.*(abs(t)>=1);
XT = 14*ones(size(t))/9;
for n=1:100
    w=n*pi;
    an = 4*sin(w/3)/w + 24*cos(w)/(w*w) + 36*sin(w/3)/(w^3);
    XT = XT + an*cos(w*t/3);
end

plot(t,x,'.g', t, XT, 'r');
