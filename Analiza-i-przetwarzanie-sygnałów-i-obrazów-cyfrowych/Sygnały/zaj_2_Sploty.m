%%
close all; clear; clc;
 
x = [3+3i, -2-1i, 0, -4+2i]; 
y = [-3-1i,-3-1i,-3+1i]; 
splot = conv(x,y)
korel = xcorr(x,y)

%%
close all; clear; clc;
 
Fs = 100;
t = 0 : 1/Fs : 10;
x = 1.0*(abs(t-5)<=1.5);
N = 3; %Zmiana n na wieksza wartosc tworzy trapez
y = ones(1,N)/N;
splot = conv(x,y,'same');
plot(t,x,'r',t,splot,'g');
ylim([-0.5,1.5]);

%%
close all; clear; clc;
 
Fs = 100;
t = 0 : 1/Fs : 10;
x = 1.0*(abs(t-5)<=1.5);
xs = x + 0.1*randn(size(t))
N = 51; 
%y = ones(1,N)/N;
y = fspecial('gaussian', [1 N], N/4);
splot = conv(xs,y,'same');
plot(t,x,'r',t,splot,'g');

%%
close all; clear; clc;

Fs = 100;
t = 0 : 1/Fs : 20;
x = (mod(t,2)==0);
od = 0.2;
y = exp((-(t-10).*(t-10))/(2*od*od));
subplot(211), plot(t, x, 'r', t, y, 'g');
xy = conv(x,y,'same');
subplot(212), plot(t, xy);
 
%%
close all; clear; clc;

%korelacja

Fs = 100;
t = 0 : 1/Fs : 10;
x1 = 1  *(1-abs(t-4)/1) .* (abs(t-4)<=1);
x2 = 0.9*(1-abs(t-7)/1.5) .* (abs(t-7)<=1.5);
xc = xcorr(x1,x2);  %zmiana miesjcami x1 x2 nie da tego samego wyniku
tc = -10 : 1/Fs : 10;
subplot(211), plot(t,x1,'r',t,x2,'g');
subplot(212), plot(tc, xc);

%%
close all; clear; clc;
a = load('corr_02.txt');
t = a(:,1);
x = a(:,2)
%plot(t,x);
dt = t(2)-t(1);
t_pros = 0 : dt : 16;
pros = 0.65*ones(size(t_pros));
xc = xcorr(x, pros);
tc = -200 : dt : 200;
subplot(211), plot(t,x,'r',t_pros+54,pros,'.g');
subplot(212), plot(tc,xc);
nr = find(xc == max(xc),3,'first');
tc(nr)

%%
close all; clear; clc;
a = load('corr_02.txt');
t = a(:,1)';
x = a(:,2)';

dt = t(2)-t(1);
tt = 0 : dt : 10; %krok czasowy
troj = 1*(1-abs(tt-5)/5);
subplot(211), plot(t,x,'r',tt,troj,'.g');
%%xc = xcorr(x, troj);
%%xc = xcorr(x.^4, troj.^4);
%%xc = xcorr(x, troj) + 2*xcorr(1-x,1-troj);
tc = -200 : dt : 200;
nr = find(xc==max(xc), 3, 'first');
tc(nr)
subplot(212); plot(tc, xc);                                                                                                                                                                                                                                                                                                                                                                                                                      

%%
close all; clear; clc;

a = load('corr_02.txt');
t = a(:,1)';
x = a(:,2)';

dt = t(2)-t(1);
tt = 0 : dt : 9;
pila = mod(tt,9)/9;
subplot(211), plot(t,x,'r',tt+72,pila,'.g');
xc = xcorr(x,pila);
tc = -200 : dt : 200;
nr = find(xc==0.999*max(xc),3,'first');
tc(nr);
subplot(212);
plot(tc,xc)

%%
close all; clear; clc;
a = load('tomo.dat.txt');

[NRP, NP] = size(a);
Fs = 10E6;
t = (0:NP-1)/Fs;
figure;
hold on;
for k=1:NRP
        plot(t, a(k,:)+k-1)
end
hold off

%%
close all; clear; clc;
a = load('tomo.dat.txt');

[NRP, NP] = size(a); % 41 rejestracji, kazda n punktow
Fs = 10E6; 
t = (0:NP-1)/Fs; % wektor czasowy
sygnal = load('tomo_sygn.dat.txt'); % plik z sygnalem zrodlowym
plot(sygnal(:,1), sygnal(:,2)); % wyswietlamy
plot(t, a(1,:));

%%
tc = (-NP+1:NP-1)/Fs %czas korelacji od -szer. sygnalu do +szer. sygnalu
odl = sqrt(0.5^2+(-0.2:0.01:0.2).^2); % odleglosc od zrodla do odbiornika (pitagoras)
figure; 
hold on;
for k=1:NRP
    xc = xcorr(a(k,:), sygnal(:,2)'); % korelacja z kazdej k-tej 
    nr = find(xc == max(xc), 1, 'first'); % szukamy maks korelacji i wypisujemy numer probki gdzie wystepuje
    FB(k)=tc(nr); % czas przyjscia do k-tego odbiornika
    plot(t, a(k,:)+k-1) 
end
hold off
v = odl./FB; % predkosc to dx/dt 
plot(v);