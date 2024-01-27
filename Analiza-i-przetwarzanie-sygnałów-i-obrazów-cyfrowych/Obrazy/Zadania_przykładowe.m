%% ZADANIA PRZYKŁADOWE NA KOLOKWIUM

%% ZAD 1
close all; clear; clc;
a = imread("onion.png");
a = median(a,3);
a = histeq(a,128);
mac = affine2d([1 0 0; 0 2 0; 0 0 1])
b = imwarp(a,mac);

subplot(121), imshow(a);
subplot(122), imshow(b);

%% ZAD 2
close all; clear; clc;
a = imread("cameraman.tif");
N = 3;
for k = 1 : 12
    maska = fspecial("gaussian", [N N], N/4);
    b = imfilter(a, maska);
    subplot(3,4,k), imshow(b), title(["Maska: ", N]);
    N = N+2;
end

%% ZAD 3
close all; clear; clc;
h = round(sqrt(100^2-50^2));

a = false(200,200);
x = [100,50,150];
y = [56,144,144];
a = roipoly(a,x,y);
imshow(a)

bwperim = regionprops(bwperim(a),'Perimeter');
sobel   = regionprops(edge(a,"sobel"),'Perimeter');
canny   = regionprops(edge(a,"canny"),'Perimeter');
grad    = regionprops(a-imerode(a,ones(3)),'Perimeter');

%% ZAD 4
close all; clear; clc;
a = imread("coins.png");
monety = a > 80;
monety = medfilt2(monety, [3 3], "symmetric");
monety = bwareaopen(monety, 10);
bin = monety;
[aseg, N] = bwlabel(bin);
wynik = zeros(size(a), 'uint8');
pp = regionprops(bin, a, 'MeanIntensity');
srednie = struct2table(pp);
srednie = table2array(srednie);
[~, sortedIdx] = sort(srednie, 'descend');
selected = sortedIdx(1:6);
for i = 1 : 6
    moneta = uint8(aseg == selected(i)) .* a;
    wynik = wynik + moneta;
end
subplot(121), imshow(a);
subplot(122), imshow(wynik);

%% ZAD 5
close all; clear; clc;
a = imread("blobs.png");
a = imclearborder(a);
a = bwareaopen(a,5);
imshow(a)
[aseg, N] = bwlabel(a);
for i = 1 : N
    figura = (aseg == i);
    pole = bwarea(figura(:));
    obwod= bwarea(bwperim(figura));
    bwk = 4*pi*pole/(obwod*obwod);
    aseg(aseg==i)=bwk;
end
imagesc(aseg)

%% ZAD 6 
close all; clear; clc;
obraz = imread("pout.tif");
obraz = imadjust(obraz,[0.3 0.8],[0.1 1.0]);
[length width] = size(obraz);
a = obraz;

for i = 1 : length
    for j = 1 : width
        if (mod(i,10)==0) || (mod(j,10)==0)
            a(i,j) = a(i,j) + 10;
        end
    end
end
figure;
a = double(a)/255;
subplot(121), imshow(obraz)
subplot(122), imshow(a)

A = fftshift(fft2(a));
WA = abs(A);
[nz nx] = size(A);
fz = linspace(-nz/2,nz/2,nz);
fx = linspace(-nx/2,nx/2,nx);
[FX FZ] = meshgrid(fx,fz);
f = sqrt(FX.^2 + FZ.^2);
filtr = medfilt2(a, [3 3],"symmetric");
%filtr = entropyfilt(a,ones(3))
%filtr = rangefilt(a, ones(93));
%filtr = stdfilt(a,ones(5));
an = real(ifft2(ifftshift(filtr.*A)));

figure;
subplot(121), imshow(a)
subplot(122), imagesc(fx,fz, log(WA+0.0001)),axis image;

figure;
subplot(121), imshow(obraz)
subplot(122), imshow(an)

%% ZAD 7
close all; clear; clc;
a = imread('text.png');
e1 = a(11:23,52:62);
e2 = rot90(e1);

xc1 = real(ifft2( fft2(a) .* fft2(rot90(e1,2),256,256) ));
xc2 = real(ifft2( fft2(a) .* fft2(rot90(e2,2),256,256) ));

wynik1 = xc1 > 0.9999 * max(xc1(:));
wynik2 = xc2 > 0.9999 * max(xc2(:));
wynik = wynik1 + wynik2;
wynik = imdilate(wynik, strel('arbitrary',[1 1 1 1 0;0 0 0 0 0;0 0 0 0 0;0 0 0 0 0;0 0 0 0 0]));
wynik = wynik(:,:)>0;

wynik = imreconstruct(wynik,a);
wynik = imoverlay(a, wynik,'r');
subplot(121),imshow(a)
subplot(122),imshow(wynik)

%% ZADANIE Z KOLOKWIUM 1 GRUPY
close all; clear; clc;
obraz = imread("kasa.png");
obraz2 = rgb2gray(obraz);
a = obraz2 < 110;
a = bwareaopen(a,50);
a = medfilt2(a,[13 13]);
D = imerode(a,strel('disk',30));
D = bwdist(D);
a = a & (watershed(D)>0);
[aseg N] = bwlabel(a);
pp = regionprops(aseg, 'all');
monety = zeros(size(a));
gr1 = zeros(size(a));
gr2 = zeros(size(a));
gr3 = zeros(size(a));
liczba1 = 0;
liczba2 = 0;
liczba3 = 0;
for k = 1 : N
    moneta = (aseg == k);
    pole = pp(k).Area;
    if pp(k).Circularity > 0.75 && pole > 2000
        monety = monety | moneta;
        if pole < 8500
            moneta = bwperim(moneta);
            moneta = imdilate(moneta,ones(5));
            gr1 = gr1 | moneta;
            liczba1 = liczba1 +1;
        end 
        if pole > 8500 && pole < 12000
            moneta = bwperim(moneta);
            moneta = imdilate(moneta,ones(5));
            gr2 = gr2 | moneta;
            liczba2 = liczba2 + 1;
        end
        if pole > 12000 && pole < 14000
            moneta = bwperim(moneta);
            moneta = imdilate(moneta,ones(5));
            gr3 = gr3 | moneta;
            liczba3 = liczba3 + 1;
        end
    end
end
liczba1
liczba2
liczba3
obraz = imoverlay(obraz,gr1,'b');
obraz = imoverlay(obraz,gr2,'r');
obraz = imoverlay(obraz,gr3,'g');
imshow(obraz)
