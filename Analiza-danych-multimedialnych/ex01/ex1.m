%%
close all; clear; clc;

Fs = 500;
t = 0 : 1/Fs : 10; 

x = 1*exp(-(t-5).^2/2) + 1*sin(2*pi*(40-t).*t) + (0.05*t+0.5).*sin(2*pi*t/0.1);

XT = fftshift(fft(x));
N = length(x);
f = linspace(-Fs/2, Fs/2, N);
WA = abs(XT);

BS = 1./(1+(6*f./(f.^2-100)).^8);
xn = real(ifft(ifftshift(BS.*XT)));

subplot(2,1,1), plot(t, x, 'g', t, xn, 'r');
subplot(2,1,2), plot(f, WA, 'g', f, 2000*BS, 'r');
xlim([0,Fs/2]);

%%
close all; clear; clc;

[a, Fs] = audioread('E-A-D.mp3');

x = a(:,1)';
N = length(x);
t = (0:N-1)/Fs;

XT = fftshift(fft(x));
N = length(x);
f = linspace(-Fs/2, Fs/2, N);
WA = abs(XT);

BS = zeros(1,N);
for k = 1 : 8
    BS = BS + exp(-(abs(f)-k*441.5).^2/500);
end
BS = 1 - BS;
BS = BS .* (abs(f)<2000); %.* (WA>200);
xn = real(ifft(ifftshift(BS.*XT)));

subplot(2,1,1), plot(t, x, 'g', t, xn, 'r');
subplot(2,1,2), plot(f, WA, 'g', f, BS*2000, 'r');
xlim([0, 4000]);

krok = 100;
nn = 2024;
okno = blackman(nn)';
Nz = ceil(nn*3000/Fs);
Nx = floor((N-nn)/krok);
A = zeros(Nz, Nx);
for kx = 1 : Nx
    st = (kx-1)*krok+1;
    xx = x(st:st+nn-1).*okno;
    WAA = abs(fft(xx));
    A(:,kx) = WAA(1:Nz)';
end
tt = (0:Nx-1)*krok/Fs;
ff = (0 : Nz-1)*Fs/nn;
figure;
imagesc(tt,ff,A);

