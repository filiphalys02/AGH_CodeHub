close all; clear; clc;
% -------------->  O B R A Z Y  <----------------

%% Wyodrebnianie skladowych R,G,B z kolorowego obrazu
close all; clear; clc;
a = imread('onion.png');
r = a(:,:,1);
g = a(:,:,2);
b = a(:,:,3);
subplot(221), imshow(r);
subplot(222), imshow(g);
subplot(223), imshow(b);
subplot(224), imshow(a);

%% konwersja rgb -> ind oraz ind -> rgb
close all; clear; clc;
a = imread('onion.png');
[map, leg] = rgb2ind(a,1000); % liczba po prawej zmienia ilość kolorów
b = ind2rgb(map, leg);
subplot(121), imshow(a);
subplot(122), imshow(b);

%% 3 metody interpolacji
close all; clear; clc;
a = checkerboard(8,8,8);
a = imread('cameraman.tif');
skala = 0.8;
subplot(221), imshow(a);
b = imresize(a,skala,'nearest'); % 3 argument to narzedzie interpolacji
c = imresize(a,skala,'bilinear'); % 3 argument to narzedzie interpolacji
d = imresize(a,skala,'bicubic'); % 3 argument to narzedzie interpolacji
subplot(222), imshow(b);
subplot(223), imshow(c);
subplot(224), imshow(d);

%% Przeksztalcenia punktowe - liniowe przeksztalcenia
a = imread('cameraman.tif');
a = double(a)/255; % konwersja do double
b = a+50;
b = b-100;
b = b+50;
b = uint8(255*b); % konwersja do int
subplot(121), imshow(a);
subplot(122), imshow(b);

%% Przeksztalcenia punktowe - nieliniowe przeksztalcenia
close all; clear; clc;
a = imread('cameraman.tif');
a = double(a)/255;
g = 2.^(-3:2);
figure;
for k = 1 : 6
    b = a.^g(k);
    subplot(2,3,k), imshow(b);
    title(['\gamma = ', num2str(g(k))]);
end

%% Przeksztalcenia punktowe - wyrownywanie histogramu
close all; clear; clc;
a = imread('pout.tif');
subplot(221), imshow(a);
subplot(222), imhist(a, 256);

%%
close all; clear; clc;
a = imread('pout.tif');
b = histeq(a,255);
subplot(221), imshow(a);
subplot(222), imhist(a, 256);
subplot(223), imshow(b);
subplot(224), imhist(b, 256);

%% Przekszatlcenia punktowe - normalizacja
close all; clear; clc;
a = imread('pout.tif');
b = imadjust(a,  [0.3; 0.8], [0.2; 1]);
subplot(221), imshow(a);
subplot(222), imhist(a, 256);
subplot(223), imshow(b);
subplot(224), imhist(b, 256);



%% Przeksztalcenia geometryczne - obrot 'crop'
close all; clear; clc;
a = imread('cameraman.tif');
a1 = imrotate(a, 30, 'nearest', 'crop'); % 'nearest' 'bilinear' 'bicubic'
length(a1)
subplot(121), imshow(a);
subplot(122), imshow(a1);

%% Przeksztalcenia geometryczne - obrot 'loose'
close all; clear; clc;
a = imread('cameraman.tif');
a1 = imrotate(a, 30, 'nearest', 'loose'); % 'nearest' 'bilinear' 'bicubic'
length(a1)
subplot(121), imshow(a);
subplot(122), imshow(a1);

%% Przeksztalcenia geometryczne - odbicia symetryczne
close all; clear; clc;
a = imread('cameraman.tif');
a1 = fliplr(a);
a2 = flipud(a);
subplot(131), imshow(a);
subplot(132), imshow(a1);
subplot(133), imshow(a2);

%% Przeksztalcenia geometryczne - dodawanie wierszy, kolumn do obrazu
close all; clear; clc;
a = imread('onion.png');
% 'pre'-gora+lewo   'post'-dol+prawo    both-wszystkie
a1 = padarray(a,[30,30],'circular','both'); % cykliczne
a2 = padarray(a,[30,30],'replicate','both'); % skrajne wartosci
a3 = padarray(a,[30,30],'symmetric','both'); % odbicie symetryczne
subplot(221), imshow(a);
subplot(222), imshow(a1);
subplot(223), imshow(a2);
subplot(224), imshow(a3);

%% Przeksztalcenia geometryczne - zmiana ksztaltu i wymiarow obrazu
close all; clear; clc;
a = imread('cameraman.tif');
%b = reshape(a,[128,512]);
b = imresize(a,[1024,1024]);
sizeA = size(a)
sizeB = size(b)
subplot(121), imshow(a);
subplot(122), imshow(b);

%% Przeksztalcenia geometryczne - zmiana ksztaltu i wymiarow obrazu - affine2d
close all; clear; clc;
a = imread('cameraman.tif');
maska = affine2d([1 0 0; 0 1 0; 0 0 1]); % mnozenie raz macierz jednostkowa (nic sie nie dzieje)
a1 = imwarp(a,maska);
subplot(121), imshow(a);
subplot(122), imshow(a1);

%% Przeksztalcenia geometryczne - zmiana ksztaltu i wymiarow obrazu - affine2d
close all; clear; clc;
a = imread('cameraman.tif');
% affine2d(a b 0; c d 0; e f 1)
% a,d - skalowanie obrazu, wartosc ujemna robi lustrzane odbicie
% b,c - przesuniecie rogow
mac = affine2d([-1 1 0; 0 -2 0; 0 0 1]);
a1 = imwarp(a,mac);
subplot(121), imshow(a);
subplot(122), imshow(a1);

%% Przeksztalcenia geometryczne - zmiana ksztaltu i wymiarow obrazu - projective2d
close all; clear; clc;
a = imread('cameraman.tif');
% mnozenie razy macierz jednostkowa (nic sie nie dzieje)
mac = projective2d([1 0 0; 0 1 0; 0 0 1]);
a1 = imwarp(a,mac);
subplot(121), imshow(a);
subplot(122), imshow(a1);

%% Przeksztalcenia geometryczne - zmiana ksztaltu i wymiarow obrazu - projective2d
close all; clear; clc;
a = imread('cameraman.tif');
% projective2d(1 x x; x 1 x; x x 1)
% zmienianie x-ów powoduje edycję obrazu
mac = projective2d([1 0.1 0.001; 0.1 1 0; 0 0 1]);
a1 = imwarp(a,mac);
subplot(121), imshow(a);
subplot(122), imshow(a1);

%% Narzedzie cpselect() sluzy do zbierania punktow z obrazu sprzed i po korekcji
close all; clear; clc;
a = imread('cameraman.tif');
a1 = imrotate(a, 30, 'nearest', 'crop');
subplot(121), imshow(a);
subplot(122), imshow(a1);
cpselect(a1,a);
% wybieram odpowiadające sobie punkty z lewego i prawego obrazu (im więcej, tym dokładniej)

%% Przeksztalcenia geometryczne - rozpoznanie transformacji geometrycznej
a = imread('cameraman.tif');
a1 = imrotate(a, 30, 'nearest', 'crop');
subplot(121), imshow(a);
subplot(122), imshow(a1);
T = fitgeotrans(movingPoints, fixedPoints,'affine');
T.T