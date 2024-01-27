%% Widmo amplitudowe
close all; clear; clc;
a = imread('cameraman.tif');
a = double(a)/255;
A = fftshift(fft2(a));
WA = abs(A);
[Nz, Nx] = size(a);
fx = linspace(-Nx/2,Nx/2,Nx);
fz = linspace(-Nz/2,Nz/2,Nz);
subplot(121), imshow(a);
subplot(122), imagesc(fx,fz,log(WA+0.001));

%% Filtracja
close all; clear; clc;
a = imread('cameraman.tif');
a = double(a)/255;
A = fftshift(fft2(a));
WA = abs(A);
[Nz, Nx] = size(a);
fx = linspace(-Nx/2,Nx/2,Nx);
fz = linspace(-Nz/2,Nz/2,Nz);
[FX,FZ] = meshgrid(fx,fz);
f = sqrt(FX.^2 + FZ.^2);
LP = 1.0*(f<10);
LP = 1./(1+(f/5).^6);
LP = 1./(1+(f/25).^8);
LP = 1./(1+(f/100).^8)
an = real(ifft2(ifftshift(LP .* A)));
subplot(121), imshow(a);
subplot(122), imshow(an)


%%
close all; clear; clc;
a = imread('F_dzieciol.png');
a = double(a)/255;
subplot(221), imshow(a);
[Nz, Nx, k] = size(a);
fx = linspace(-0.5,0.5,Nx);
fz = linspace(-0.5,0.5,Nz);
[FX, FZ] = meshgrid(fx,fz);
BS = (abs(FX)>0.17 & abs(FX)<0.25 & abs(FZ)>0.15 & abs(FZ)<0.25);
BS = -BS;
b = a;
for k =1 : 3
    XT = fftshift(fft2(a(:,:,k)));
    WA = abs(XT);
    subplot(2,2,k+1), imagesc(fx,fz,log(WA+0.001).*BS);
    b(:,:,k) = real(ifft2(ifftshift(BS.*XT)));
    axis image;
end
figure;
imshow(b);

%% szukanie a
close all; clear; clc;
a = imread("text.png");
imshow(a);
wzor = a(31:48,85:101);
imshow(wzor);
xc = real(ifft2(fft2(a).*fft2(rot90(wzor,2), 256, 256)));
imagesc(xc);
wynik = xc>=max(xc(:));
subplot(121), imshow(a);
subplot(122), imshow(imdilate(wynik, ones(5)));

%% szukanie r
close all; clear; clc;
a = imread("text.png");
imshow(a);
wzor = a(31:45,4:13);
imshow(wzor);
xc = real(ifft2(fft2(a).*fft2(rot90(wzor,2), 256, 256))); % korelacja
xc = xc + real(ifft2(fft2(1-a).*fft2(rot90(1-wzor,2), 256, 256))); % korelacja odwrotna
imagesc(xc);
wynik = xc>=0.999999*max(xc(:));
subplot(121), imshow(a);
subplot(122), imshow(imdilate(wynik, ones(5)));
