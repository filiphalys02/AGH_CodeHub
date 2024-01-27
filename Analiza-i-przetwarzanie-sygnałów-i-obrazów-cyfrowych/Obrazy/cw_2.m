% FILTRACJA:
%  - liniowa: dolnoprzepustowa, górnoprzepustowa
%  - nieliniowa: odszumiająca, krawędziowa, inne
%% Filtracja liniowa - dolnoprzepustowa
close all; clear; clc;
a = imread('cameraman.tif');
N = 5;
LP = ones(N,N)/(N*N); % filtr dolnoprzepustowy
LP = fspecial('gaussian', [N N], N/8);
b = imfilter(a, LP, 'replicate'); %filtracja obrazu
% opcje uzupełnienia wartości skrajnych:
% - symmetric: 3 2 1 | 1 2 3 4 5 | 5 4 3 
% - replicate: 1 1 1 | 1 2 3 4 5 | 5 5 5
% - circular:  3 4 5 | 1 2 3 4 5 | 1 2 3
subplot(121), imshow(a);
subplot(122), imshow(b);

%% Filtracja liniowa - dolnoprzepustowa
close all; clear; clc;
a = imread('cameraman.tif');
N = 7;
LP = ones(N,N)/(N*N);
LP = fspecial('gaussian', [N N], N/8);
b = medfilt2(a, [N N], 'summetric'); % dwumywiarowa filtracja
% opcje uzupełnienia wartości skrajnych:
% - symmetric: 3 2 1 | 1 2 3 4 5 | 5 4 3 
subplot(121), imshow(a);
subplot(122), imshow(b);

%% Filtracja liniowa - dolnoprzepustowa
close all; clear; clc;
a = imread('cameraman.tif');
N = 7;
LP = ones(N,N)/(N*N);
LP = fspecial('gaussian', [N N], N/8);
b = wiener2(a, [N N]); % dwumywiarowa filtracja 
% brak opcji uzupełniania wartości skrajnych
subplot(121), imshow(a);
subplot(122), imshow(b);

%% Filtracja liniowa - gornoprzepustowa
close all; clear; clc;
a = imread('cameraman.tif');
HP = [1 1 1; 0 0 0; -1 -1 -1];
b = imfilter(a, HP);
subplot(121), imshow(a);
subplot(122), imshow(b);

%% Filtracja liniowa - gornoprzepustowa
close all; clear; clc;
a = imread('cameraman.tif');
a = double(a)/255;
HP = [1 1 1; 0 0 0; -1 -1 -1]';
b = abs(imfilter(a, HP)); % krawędzie pionowe i ukośne 
subplot(121), imshow(a);
subplot(122), imshow(b);

%% Filtracja liniowa - gornoprzepustowa
close all; clear; clc;
a = imread('cameraman.tif');
a = double(a)/255;
HP = [1 1 1; 0 0 0; -1 -1 -1];
b = abs(imfilter(a, HP)).^2;
b = sqrt(b + abs(imfilter(a,HP')).^2); % wszystkie krawędzie
subplot(121), imshow(a);
subplot(122), imshow(b);

%% Filtracja liniowa - gornoprzepustowa
% zad1. stworz obraz 200x200px, czarne tło, na środku biały kwadrat o boku
% 80, stwóz filtrację, która wykrywa tylko narożniki
close all; clear; clc;
a = zeros([200 200]);
a(61:140,61:140) = a(61:140,61:140) + 1;
HP = [1 0 -1];
b = imfilter(imfilter(a, HP),HP')
b = abs(b)
a =uint8(a + (a.*b));
leg = [0 0 0; 1 1 1; 0 0 1];
subplot(131), imshow(a);
subplot(132), imshow(b);
subplot(133), imshow(a,leg);

%% Filtracja liniowa - gornoprzepustowa (laplasjan)
close all; clear; clc;
a = imread('cameraman.tif');
maska = [-1 -1 -1; -1 8 -1; -1 -1 -1];
a1 = imfilter(a, maska);
maska(2,2)=9;
a2 = imfilter(a, maska);
subplot(121), imshow(a1); 
subplot(122), imshow(a2);

%% Filtracja liniowa - gornoprzepustowa (laplasjan)
close all; clear; clc;
a = imread('cameraman.tif');
maska = [-1 -1 -1; -1 8 -1; -1 -1 -1];
maska(2,2)=9;
a1 = imfilter(a, maska);

subplot(121), imshow(a);
subplot(122), imshow(a1);

%% Filtracja nieliniowa - rangefilt, stdfilt, entropyfilt
close all; clear; clc;
a = imread('cameraman.tif');

b = rangefilt(a, ones(5));  % range filtr
b = stdfilt(a, ones(5));    % filtr odch. stand.
b = entropyfilt(a, ones(9)) % filtr entropii
imagesc(b); axis image; colorbar('vertical');

%% Filtracja nieliniowa - funkcja edge
close all; clear; clc;
a = zeros([200 200]);
a(61:140,61:140) = a(61:140,61:140) + 1;
a1 = edge(a,'sobel');
a2 = edge(a,'canny');
subplot(121), imshow(a1);
subplot(122), imshow(a2);

%% Dekonwolucja
close all; clear; clc;
a = imread('cameraman.tif');
maska = fspecial('motion', 11, 30);
b = imfilter(a,maska,'replicate');
c = deconvblind(b,maska);   % dekonwolucja ślepa
d = deconvlucy(b,maska);    % dekonwolucja lucy-richarldsona
e = deconvwnr(b,maska);     % dekonwolucja winera
f = deconvreg(b, maska);    % dekonwolucja regularyzowana
subplot(121), imshow(c);
subplot(122), imshow(b);
