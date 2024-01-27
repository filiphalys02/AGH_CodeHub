%% Obrazy I - Formaty kodowania koloru
close all; clear; clc;
rgb = imread("filtered_peppers.png");
gray = rgb2gray(rgb);
[map, leg] = rgb2ind(rgb,30);
ind = ind2rgb(map,leg);
ycbcr = rgb2ycbcr(rgb);
subplot(221), imshow(rgb), title("RGB");
subplot(222), imshow(gray), title("GRAY");
subplot(223), imshow(ind), title("INS");
subplot(224), imshow(ycbcr), title("YCbCr");

%% Obrazy I - Rozdzielczość przestrzenna
close all; clear; clc;
a = imread("F_dzieciol.png");
skala = 0.2;
nearest = imresize(a, skala, 'nearest');
bilinear= imresize(a, skala, 'bilinear');
bicubic = imresize(a, skala, 'bicubic');
subplot(221), imshow(a), title("Normal");
subplot(222), imshow(nearest), title("Nearest");
subplot(223), imshow(bilinear), title("Bilinear");
subplot(224), imshow(bicubic), title("Bicubic");

%% Obrazy I - Przekształcenia punktowe - liniowe przekształcenia
close all; clear; clc;
a = imread("cameraman.tif");
b = a + 100
c = a - 100
d = a * 4
subplot(221), imshow(a), title("a")
subplot(222), imshow(b), title("a+100")
subplot(223), imshow(c), title("a-100")
subplot(224), imshow(d), title("a*4")

%% Obrazy I - Przekształcenia punktowe - nieliniowe przekształcenia (korekta gamma)
close all; clear; clc;
a = imread("cameraman.tif");
a = double(a)/255;
gamma = 2.^[-3,-2,-1,0,1,2];
for k = 1 : 6
    b = a .^ gamma(k);
    subplot(2,3,k), imshow(b);
    title(['\gamma = ', num2str(gamma(k))])
end

%% Obrazy I - Przekształcenia punktowe - wyrównywanie histogramu
close all; clear; clc;
a = imread("pout.tif");
b = histeq(a);
subplot(221), imshow(a), title("przed wyrównaniem")
subplot(222), imhist(a), title("przed wyrównaniem")
subplot(223), imshow(b), title("po wyrównaniu")
subplot(224), imhist(b), title("po wyrównaniu")

%% Obrazy I - Przekształcenia punktowe - normalizacja
close all; clear; clc;
a = imread("pout.tif");
b = imadjust(a, [0.3;0.8], [0.2;0.9]);
subplot(221), imshow(a), title("przed normalizacją")
subplot(222), imhist(a), title("przed normalizacją")
subplot(223), imshow(b), title("po normalizacji")
subplot(224), imhist(b), title("po normalizacji")

%% Obrazy I - Przekształcenia punktowe - binaryzacja
close all; clear; clc;
a = imread("filtered_peppers.png");
a = rgb2gray(a)
b = a>100
c = a<100
d = a>100 & a<150
subplot(221), imshow(a), title("a")
subplot(222), imshow(b), title("a>100")
subplot(223), imshow(c), title("a<100")
subplot(224), imshow(d), title("a>100 & a<150")

%% Obrazy I - Przekształcenia geometryczne - obrót
close all; clear; clc;
a = imread("cameraman.tif");
b = imrotate(a,45,"nearest","crop");
c = imrotate(a,45,"bilinear","crop");
d = imrotate(a,45,"bicubic","crop");
e = imrotate(a,45,"nearest","loose");
f = imrotate(a,45,"bilinear","loose");
g = imrotate(a,45,"bicubic","loose");
subplot(332), imshow(a), title("a");
subplot(334), imshow(b), title("crop - nearest");
subplot(335), imshow(c), title("crop - bilinear");
subplot(336), imshow(d), title("crop - bicubic");
subplot(337), imshow(e), title("loose - nearest");
subplot(338), imshow(f), title("loose - bilinear");
subplot(339), imshow(g), title("loose - bicubic");

%% Obrazy I - Przekształcenia geometryczne - odbicia symetryczne
close all; clear; clc;
a = imread("cameraman.tif");
b = fliplr(a);
c = flipud(a);
subplot(131), imshow(a), title("a");
subplot(132), imshow(b), title("fliplr");
subplot(133), imshow(c), title("flipud");

%% Obrazy I - Przekształcenia geometryczne - dodawanie wierszy i kolumn
close all; clear; clc;
a = imread("cameraman.tif");
% 'pre' góra i lewo     'post' dół i prawo      'both' wszystko 
b = padarray(a,[50 0],'circular','both');
c = padarray(a,[50 0],'replicate','both');
d = padarray(a,[50 0],'symmetric','both');
e = padarray(a,[0 50],'circular','both');
f = padarray(a,[0 50],'replicate','both');
g = padarray(a,[0 50],'symmetric','both');
subplot(332), imshow(a), title("a");
subplot(334), imshow(b), title("circular");
subplot(335), imshow(c), title("replicate");
subplot(336), imshow(d), title("symmetric");
subplot(337), imshow(e);
subplot(338), imshow(f);
subplot(339), imshow(g);

%% Obrazy I - Przekształcenia geometryczne - zmiana kształtu i wymiarów obrazu
close all; clear; clc;
a = imread("cameraman.tif");
% affine2d(a b 0; c d 0; e f 1)
% a,d - skalowanie obrazu, wartosc ujemna robi lustrzane odbicie
% b,c - przesuniecie rogow
maska = affine2d([1 0 0; 0 1 0; 0 0 1]);
b = imwarp(a, maska);
% projective2d(1 x x; x 1 x; x x 1)
maska = projective2d([1 0 0; 0 1 0; 0 0 1]);
c = imwarp(a, maska);
subplot(121), imshow(b), title("affine2d");
subplot(122), imshow(c), title("projective2d");

%% Obrazy I - Przekształcenia geometryczne - rozpoznanie transformacji geometrycznej
%cpselect()
a = imread('cameraman.tif');
a1 = imrotate(a, 30, 'nearest', 'crop');
subplot(121), imshow(a);
subplot(122), imshow(a1);
T = fitgeotrans(movingPoints, fixedPoints,'affine');
T.T
