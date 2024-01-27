close all; clear; clc;
a = false(100,100);
for k = 1:2
    x = ceil(100*rand(1));
    y = ceil(100*rand(1));
    a(x,y) = true;
end
imshow(a);

a1 = bwdist(a, 'euclidean')
a2 = bwdist(a, 'quasi-euclidean')
a3 = bwdist(a, 'cityblock')
a4 = bwdist(a, 'chessboard')

subplot(221), imagesc(a1); axis image; colorbar('vertical');
subplot(222), imagesc(a2); axis image; colorbar('vertical');
subplot(223), imagesc(a3); axis image; colorbar('vertical');
subplot(224), imagesc(a4); axis image; colorbar('vertical');

%% 
close all; clear; clc;
% w lesie, Droga główna>20px, droga poboczna<10px, woda>15px
% imtool(a)
a = imread('new_map.bmp');
las = a(:,:,1)==185 & a(:,:,2)==215 & a(:,:,3)==170;
dg = a(:,:,1)==255 & a(:,:,2)==245 & a(:,:,3)==120;
dg = imclose(dg, ones(1,3))
dp = a(:,:,1)==255 & a(:,:,2)==255 & a(:,:,3)==255;
dp = medfilt2(dp, [3 3], 'symmetric')
woda = a(:,:,1)>60  & a(:,:,2)>155 & a(:,:,3)>200;
woda = woda & a(:,:,1)<160 & a(:,:,2)<220;
wynik = las & bwdist(dg)>20 & bwdist(dp)<10 & bwdist(woda)>15 
wynik = imoverlay(a, wynik, 'r')
subplot(121), imshow(a);
subplot(122), imshow(wynik);

%% dzial wodny 1 metoda
close all; clear; clc;
a = false(300,200);
a([100,200],100)=true;
a = bwdist(a)<55;
D = -bwdist(~a);
L = watershed(D);
a = a & (L>0);
%imagesc(L), axis image
imshow(a)

%% dzial wodny 2 metoda
close all; clear; clc;
a = false(300,200);
a([100,200],100)=true;
a = bwdist(a)<55;
d = imerode(a, strel('disk',25));
D = bwdist(d);
L = watershed(D);
a = a & (L>0);
imshow(a)
% zaczynamy 1 metoda, jesli nie dziala, probojemy druga

%% ANALIZA OBRAZOW
% 1) Akwizycja
% 2) Przetwarzanie wtsepne
% 3) Segmentacja
% 4) Analiza 
% 5) Wizualizacja
% * Weryfikacja po każdym z etapów

%%
close all; clear; clc;
% cel - policz monety na zdjeciu, 
a = imread('coins.png');
bin = a>90;
bin = medfilt2(bin, [3 3]);
[aseg, N] = bwlabel(bin);
disp(N)
subplot(121), imshow(a)
subplot(122), imagesc(aseg)

%%
close all; clear; clc;
% cel - wyznacz 5 najmniejszych monet
a = imread('coins.png');
bin = a>90
bin = medfilt2(bin, [3 3]);
[aseg, N] = bwlabel(bin);
pole = zeros(N,1);
for k=1:N
    temp = (aseg==k);
    pole(k,1) = sum(temp(:));
end
pole2 = sort(pole);
th = pole2(5);
wynik = zeros(size(a),'uint8');
for k = 1:N
    if pole(k)<=th
        wynik = wynik + uint8(aseg==k).*a;
    end
end
subplot(121), imshow(a)
subplot(122), imshow(wynik)

%%
close all; clear; clc;
% cel - histogram pól i obwodów ziaren
a = imread('rice.png');
b = imtophat(a, strel('disk',9));
b = imadjust(b);
bin = b>90;
bin = bwmorph(bin, 'clean');
bin = bwareaopen(bin, 10);
%D = -bwdist(~bin);
%bin = bin & (watershed(D)>0)
subplot(121), imshow(a);
subplot(122), imshow(bin);
D = imerode(bin,ones(4))
D = bwdist(D);
bin = bin & (watershed(D)>0);
bin = imclearborder(bin);
[aseg,N] = bwlabel(bin);
pole = zeros(N,1);
obwod = zeros(N,1);
for k = 1:N
    temp = (aseg==k);
    pole(k,1) = sum(temp(:));
    obwod(k,1) = bwarea(bwperim(temp));
end
subplot(121), histogram(pole);
subplot(122), histogram(obwod);
[mean(pole) std(pole)]
[mean(obwod) std(obwod)]

%jk = uint8(bin).*a;
%kj = uint8(~bin).*a;
%subplot(121), imshow(jk)
%subplot(122), imshow(kj)



