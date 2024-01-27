%% Obrazy III - FFT2 -> WA
a = imread("pout.tif");
a = double(a)/255;
A = fftshift(fft2(a))
WA = abs(A)
[nz, nx] = size(a);
fx = linspace(-nx/2, nx/2, nx);
fz = linspace(-nz/2, nz/2, nz);
subplot(121), imshow(a);
subplot(122), imagesc(fx,fz,log(WA+0.0001));

%% Obrazy III - FFT2 -> WF
close all; clear; clc;
a = imread("pout.tif");
a = double(a)/255;
A = fftshift(fft2(a));
WF = angle(A);
[nz, nx] = size(a);
fx = linspace(-nx/2, nx/2, nx);
fz = linspace(-nz/2, nz/2, nz);
subplot(121), imshow(a);
subplot(122), imagesc(fx,fz,WF);

%% Obrazy III - IFFT2
close all; clear; clc;
a = imread("cameraman.tif");
a = double(a)/255;
fft2 = fftshift(fft2(a));
ifft2=ifft2(ifftshift(fft2));
subplot(121), imshow(a), title("Obraz przed FFT2");
subplot(122), imshow(ifft2), title("Obraz po FFT2 i IFFT2");

%% Obrazy III - Filtracja dolnoprzepustowa Butterwortwa
close all; clear; clc;
a = imread("cameraman.tif");
a = double(a)/255;
A = fftshift(fft2(a));
WA = abs(A);
[nz, nx] = size(a);
fz = linspace(-nz/2, nz/2, nz);
fx = linspace(-nx/2, nx/2, nx);
[FX, FZ] = meshgrid(fx,fz);
f = sqrt(FX.^2 + FZ.^2);
filtr = 1 ./ (1 + (f/100).^8);
an = real(ifft2(ifftshift(filtr .* A)));

subplot(121), imshow(a);
subplot(122), imshow(an);
%subplot(122), imagesc(fx,fz,log(WA+0.001));

%% Obrazy III - Filtracja pasmowozaporowa Butterworta o szerokości W
close all; clear; clc;
a = imread("cameraman.tif");
a = double(a)/255;
A = fftshift(fft2(a));
WA = abs(A);
[nz, nx] = size(a);
fz = linspace(-nz/2, nz/2, nz);
fx = linspace(-nx/2, nx/2, nx);
[FX, FZ] = meshgrid(fx,fz);
f = sqrt(FX.^2 + FZ.^2);
filtr = 1 ./ ( 1 + ( (f*2) ./ (f.^2-16) ).^8 );
an = real(ifft2(ifftshift(filtr .* A)));

subplot(121), imshow(a);
subplot(122), imshow(an);
%subplot(122), imagesc(fx,fz,log(WA+0.001));

%% Obrazy III - Filtracja Gaussowska
close all; clear; clc;
a = imread("cameraman.tif");
a = double(a)/255;
A = fftshift(fft2(a));
WA = abs(A);
[nz, nx] = size(a);
fz = linspace(-nz/2, nz/2, nz);
fx = linspace(-nx/2, nx/2, nx);
[FX, FZ] = meshgrid(fx,fz);
f = sqrt(FX.^2 + FZ.^2);
filtr = exp( -(f.^2) / (2*4096) );
an = real(ifft2(ifftshift(filtr .* A)));

subplot(121), imshow(a);
subplot(122), imshow(an);
%subplot(122), imagesc(fx,fz,log(WA+0.001));

%% Obrazy III - Korelacja (szukanie elementów - a)
close all; clear; clc;
a = imread("text.png");
wzor = a(31:48,85:101);
xc = real(ifft2( fft2(a) .* fft2(rot90(wzor,2),256,256) ));
wynik = xc >= max(xc(:));

subplot(121), imshow(a);
subplot(122), imshow(imdilate(wynik,ones(10)));

%% Obrazy III - Korelacja (szukanie elementów - s)
close all; clear; clc;
a = imread("text.png");
wzor = a(33:45,49:59);
xc = real(ifft2( fft2(a) .* fft2(rot90(wzor,2),256,256) ));
wynik = xc >= max(xc(:));
subplot(121), imshow(a)
subplot(122), imshow(wynik)

%% Obrazy III - Korelacja (szukanie elementów - r)
close all; clear; clc;
a = imread("text.png");
wzor = a(33:46,41:49);
xc = real(ifft2( fft2(a) .* fft2(rot90(wzor,2),256,256) ));
xc = xc + real(ifft2( fft2(1-a) .* fft2(rot90(1-wzor,2),256,256) ));
wynik = xc>= 0.99999*max(xc(:));
subplot(121), imshow(a);
subplot(122), imshow(wynik)

%% ZADANIE 1 
close all; clear; clc;
a = imread("onion.png");
a = double(a)/255;
a = rgb2gray(a);
A = fftshift(fft2(a));
WA= abs(A);
[nz, nx] = size(a);
fx = linspace(-nx/2,nx/2,nx);
fz = linspace(-nz/2,nz/2,nz);
[FX, FZ] = meshgrid(fx,fz);
f = sqrt(FX.^2 + FZ.^2);
filtr = 1 ./ ( 1 + (f/2).^6 );
an = real(ifft2(ifftshift( filtr .* A )));

subplot(121), imshow(a);
subplot(122), imshow(an);

%% ZADANIE 2
close all; clear; clc;
a = ones(256,256);
for i = 1 : 256 %wiersz
    for j = 1 : 256 %kolumna
        a(i,j) = sin(2*pi*(i-128)/20) + 0.5*cos(2*pi*(i-2*j)/45) + exp( (-(i-100)^2) * ((j-150)^2) / 49 );
    end
end
subplot(121), imshow(a);
subplot(122), imhist(a);

%% ZADANIE 3
close all; clear; clc;
a = imread("text.png");

wzor = a(33:45,49:59);
xc = real(ifft2( fft2(a) .* fft2(rot90(wzor,2),256,256) ));
wynik1 = xc >= max(xc(:));

wzor = a(120:130, 200:214);
xc = real(ifft2( fft2(a) .* fft2(rot90(wzor,2),256,256) ));
wynik2 = xc >= 0.99999*max(xc(:));

subplot(121), imshow(a);
subplot(122), imshow(imdilate(wynik2+wynik1,ones(5)));

