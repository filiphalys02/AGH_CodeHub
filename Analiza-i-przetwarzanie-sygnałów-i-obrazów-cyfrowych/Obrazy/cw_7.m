%% 
close all; clear; clc;
[map, leg] = imread("w_shape.png");
a = ind2rgb(map,leg);
bin = (map ~= 11);
subplot(121), imshow(a)
subplot(122), imshow(bin)

%% wyszukiwanie kol
close all; clear; clc;
% BWK = 
[map, leg] = imread("w_shape.png");
a = ind2rgb(map,leg);
bin = (map ~= 11);
kolo = false(size(bin));
[aseg, N] = bwlabel(bin);
for k = 1 : N
    temp = (aseg==k);
    pole = sum(temp(:));
    obwod = bwarea(bwperim(temp));
    bwk = 4*pi*pole / (obwod^2);
    if abs(bwk-1)<0.04
        kolo = kolo | temp; 
    end
end
subplot(121), imshow(a)
subplot(122), imshow(kolo)

%% wyszukiwanie kwadratow
close all; clear; clc;
% BWK = 4*pi*pole / (obwod^2)
[map, leg] = imread("w_shape.png");
a = ind2rgb(map,leg);
bin = (map ~= 11);
kwadrat = false(size(bin));
[aseg, N] = bwlabel(bin);
for k = 1 : N
    temp = (aseg==k);
    pole = sum(temp(:));
    obwod = bwarea(bwperim(temp));
    bwk = 4*pi*pole / (obwod^2);
    if abs(bwk-pi/4)<0.1
        kwadrat = kwadrat | temp; 
    end
end
subplot(121), imshow(a)
subplot(122), imshow(kwadrat)

%% wyszukiwanie elips
close all; clear; clc;
% BWK = 4*pi*pole / (obwod^2)
[map, leg] = imread("w_shape.png");
a = ind2rgb(map,leg);
bin = (map ~= 11);
kola = false(size(bin));
[aseg, N] = bwlabel(bin);
pp = regionprops(aseg,'all');
elipsa = false(size(bin));
for k = 1 : N
    temp = (aseg==k);
    pole = sum(temp(:));
    obwod = bwarea(bwperim(temp));
    bwk = 4*pi*pole / (obwod^2);
    if abs(bwk-1)<0.04
        kola = kola | temp; 
    end
    pole_el = pi * pp(k).MajorAxisLength * pp(k).MinorAxisLength/4;
    if abs(pole_el/pole - 1) <0.02
        elipsa = elipsa | temp;
    end
end
elipsa = elipsa & (~kola);
subplot(121), imshow(a)
subplot(122), imshow(elipsa)

%% wyszukiwanie gwiazdek
close all; clear; clc;
% BWK = 4*pi*pole / (obwod^2)
[map, leg] = imread("w_shape.png");
a = ind2rgb(map,leg);
bin = (map ~= 11);
[aseg, N] = bwlabel(bin);
pp = regionprops(aseg,'all');
gwiazdka = false(size(bin));
for k = 1 : N
    temp = (aseg==k);
    pole = sum(temp(:));
    obwod = bwarea(bwperim(temp));
    bwk = 4*pi*pole / (obwod^2);
    if (bwk>0.24 & bwk<0.27 & pp(k).EulerNumber>0)
        gwiazdka = gwiazdka | temp;
    end
end
subplot(121), imshow(a)
subplot(122), imshow(gwiazdka)

%% wyszukiwanie trójkątów
close all; clear; clc;
% BWK = 4*pi*pole / (obwod^2)
[map, leg] = imread("w_shape.png");
a = ind2rgb(map,leg);
bin = (map ~= 11);
[aseg, N] = bwlabel(bin);
pp = regionprops(aseg,'all');
trojkat = false(size(bin));
for k = 1 : N
    temp = (aseg==k);
    pole = sum(temp(:));
    obwod = bwarea(bwperim(temp));
    bwk = 4*pi*pole / (obwod^2);
    pole_t = pp(k).BoundingBox(3)*pp(k).BoundingBox(4)/2;
    if (abs(pole_t/pole-1)<0.02 & pp(k).Solidity>0.9)
        trojkat = trojkat | temp;
    end
end
subplot(121), imshow(a)
subplot(122), imshow(trojkat)

%%
close all; clear; clc;
a = imread("ebsd_12.png");
a = double(a)/255;
XT = fftshift(fft2(a));
WA = abs(XT);
fx = linspace(-0.5,0.5,256);
[FX,FZ] = meshgrid(fx,fx);
f = sqrt(FX.^2 + FZ.^2);
BS = 1./(1 + (0.02*f./(f.^2-0.066^2)).^2);
an = real(ifft2(ifftshift(BS.*XT)))
an = imadjust(an);
bin = ~(an>0.5 & an<0.9);
bin = imclearborder(bin);
bin = bwmorph(bin, 'clean');
bin = bwareaopen(bin,20);
%bin = medfilt2(bin,[3 3]);
bin = imclose(bin, ones(5));
bin = imopen(bin, ones(2));
bin = bwmorph(bin,'thin',Inf);
bin = bwmorph(bin,'spur',4);
wynik = imoverlay(a,bin,'r');
[H,T,R] = hough(bin);
piki = houghpeaks(H,10, 'threshold', 0.25*max(H(:)) );
lin = houghlines(bin,T,R,piki);
Nlin = length(lin)
imshow(a); hold on;
for k = 1 : Nlin
    line([lin(k).Point1(1),lin(k).Point2(1)],[lin(k).Point1(2),lin(k).Point2(2)], 'color', 'r');
end
hold off;
%subplot(221), imshow(a);
%subplot(222), imagesc(fx,fx,log(WA+0.001).*BS);
%axis image;
%subplot(223), imshow(an)
%subplot(224), imshow(wynik)
