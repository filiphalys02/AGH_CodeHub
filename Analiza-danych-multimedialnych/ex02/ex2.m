%%
clc; clear; close all; 

Fs = 44100;                                                                % 44,1 kHz
t = 0 : 1/Fs : 10;                                                         % czas trwania sygnału 
t2 = 0 : 1/Fs : 0.75;                                                      % czas trwania jednej nuty

x = zeros(size(t));

n2 = length(t2);                                                           % dlugosc nuty
amp = linspace(1, 0, n2).^2;                                               % amplituda maleje tylko w ramach jednej nuty

ff = 440;                                                                  % czestsotliwość poczatkowa

for k = 1:12
    st = round(k*Fs*0.75);
    x2 = amp .* sin(2*pi*ff*t2);                                           % (n0:n0+Nn-1) nuta 
    x(st:st+n2-1) = x(st:st+n2-1) + x2;
    ff = ff * 1.059;                                                       % czestotliwośc wzrasta z czasem
end

plot(t,x);
sound(x, Fs)

%%
clc; clear; close all;

a = load('SW.txt');
Fs = 44100;  
t = 0 : 1/Fs : 10; 
x = zeros(size(t));
t2 = 0 : 1/Fs : 0.5; 
N2 = length(t2);
amp = linspace(1,0,N2).^2;
for n = 1:18
    x2 = zeros(1,N2);
    for k = 1 : 4
        x2 = x2 + (amp/k) .* sin(2*pi*a(n,2)*k*t2);
    end
    st = round(a(n,1)*Fs);
    x(st:st+N2-1) = x(st:st+N2-1) + x2;
end
plot(t,x);

N = length(x);
krok = 100;
nn = 2048;
okno = blackman(nn)';
Nx = floor((N-nn)/krok);
Nz = ceil(nn*2500/Fs);
A = zeros(Nz, Nx);
for k = 1 : Nx
    st = (k-1)*krok+1;
    xx = x(st:st+nn-1).*okno;
    WA = abs(fft(xx));
    A(:,k) = WA(1:Nz);
end
tt = (0:Nx-1)*krok/Fs;
ff = (0:Nz-1)*Fs/nn;
imagesc(tt, ff, A);

%%
close all; clear; clc;
[a, Fs] = audioread('audio\A-E-F.mp3');
x = a(:,1);
prop = audioFeatureExtractor('SampleRate', Fs, 'SpectralDescriptorInput', ...
    'linearSpectrum', 'pitch', true, 'spectralFlux', true, 'harmonicRatio', ...
    true, 'spectralSpread', true);
wyn = extract(prop, x);
N = length(x);
nn = length(prop.Window);
info(prop);
t = (0:N-1)/Fs;
krok = nn - prop.OverlapLength;
tt = (1 : krok : N-nn)/Fs;
subplot(511), plot(t, x);
subplot(512), plot(tt, wyn(:,1));
subplot(513), plot(tt, wyn(:,2));
subplot(514), plot(tt, wyn(:,3));
subplot(515), plot(tt, wyn(:,4));