%% Obrazy II - filtracja liniowa 2D dolnoprzepustowa 
close all; clear; clc;
a = imread("cameraman.tif");

% opcje uzupełnienia wartości skrajnych:
% - symmetric: 3 2 1 | 1 2 3 4 5 | 5 4 3 
% - replicate: 1 1 1 | 1 2 3 4 5 | 5 5 5
% - circular:  3 4 5 | 1 2 3 4 5 | 1 2 3
maska = ones(3,3)/(3*3);
b = imfilter(a,maska,'symmetric');
maska = ones(5,5)/(5*5);
c = imfilter(a,maska,"symmetric");
maska = [1 1 1; 1 2 1; 1 1 1]/10;
d = imfilter(a,maska,"symmetric");
maska = fspecial('gaussian',[7 7], 7/8);
e = imfilter(a, maska, "symmetric");
subplot(221), imshow(b), title("maska ones(3,3)/9")
subplot(222), imshow(c), title("maska ones(5,5)/25")
subplot(223), imshow(d), title("maska [111;121;111]/10")
subplot(224), imshow(e), title("maska 'gaussian'")

%% Obrazy II - filtracja liniowa 2D górnoprzepustowa (operator Prewitta)
close all; clear; clc;
a = imread("cameraman.tif");
a = double(a)/255;
HP = [1 1 1; 0 0 0; -1 -1 -1];
b =     imfilter(a, HP );  % operator Prewitta, maska wertykalna
c = abs(imfilter(a, HP ));
d =     imfilter(a, HP');  % operator Prewitta, maska horyzontalna
e = abs(imfilter(a, HP'));
f = sqrt( abs(imfilter(a, HP)).^2 + abs(imfilter(a,HP')).^2 );

figure;
subplot(221), imshow(b), title("maska wer jednostronna")
subplot(222), imshow(c), title("maska wer obustronna")
subplot(223), imshow(d), title("maska hor jednostronna")
subplot(224), imshow(e), title("maska hor obustronna")
figure
imshow(f), title("wszystkie krawędzie")

%% Obrazy II - filtracja liniowa 2D górnoprzepustowa (operator Sobela)
close all; clear; clc;
a = imread("cameraman.tif");
a = double(a);
HP= [1 2 1; 0 0 0; -1 -2 -1];
b = imfilter(a, HP );
c = imfilter(a, HP');

subplot(121), imshow(b), title("maska wer")
subplot(122), imshow(c), title("maska hor")

%% Obrazy II - filtracja liniowa 2D górnoprzepustowa (laplasjany)
close all; clear; clc;
a = imread("cameraman.tif");
a = double(a)/255;
b = imfilter(a, [0 -1 0; -1 5 -1; 0 -1 0]);
c = imfilter(a, [-1 -1 -1; -1 9 -1; -1 -1 -1]);
d = imfilter(a, [-1 -1 -1; -1 8 -1; -1 -1 -1]);
subplot(131), imshow(b);
subplot(132), imshow(c);
subplot(133), imshow(d);

%% Obrazy II - filtracja nieliniowa (filtry: medfilt2,rangefilt,stdfilt,entropyfilt,ordfilt2)
close all; clear; clc;
a = imread('cameraman.tif');
b = medfilt2(a,[3 3]);      % filtr medianowy
c = rangefilt(a, ones(5));  % range filtr
d = stdfilt(a, ones(5));    % filtr odch. stand.
e = entropyfilt(a, ones(9));% filtr entropii
f = ordfilt2(a, 5, ones(5));% filtr ord

subplot(231), imshow(a), title("obraz")
subplot(232), imagesc(b); axis image; title("medfilt2");   %colorbar('vertical');
subplot(233), imagesc(c); axis image; title("rangefilt");  %colorbar('vertical');
subplot(234), imagesc(d); axis image; title("stdfilt");    %colorbar('vertical');
subplot(235), imagesc(e); axis image; title('entropyfilt');%colorbar('vertical');
subplot(236), imagesc(f); axis image; title('ordfilt2');   %colorbar('vertical');

%% Obrazy II - filtracja nieliniowa (funkcja edge)
close all; clear; clc;
a = zeros([200,200]);
a(60:140, 61:140)=1;
sobel = edge(a,'sobel');
canny = edge(a,'canny');
subplot(131), imshow(a)
subplot(132), imshow(sobel)
subplot(133), imshow(canny)

%% Obrazy II - filtracja adaptywna (Wienera)
close all; clear; clc;
a = imread("cameraman.tif");
b = wiener2(a, [5 5]);
imshow(b)

%% Obrazy II - Dekonwolucja
close all; clear; clc;
a = imread("cameraman.tif");
maska = fspecial('motion', 11, 30);
a = imfilter(a,maska,'replicate');
b = deconvblind(a,maska);   % dekonwolucja ślepa
c = deconvlucy(a,maska);    % dekonwolucja lucy-richarldsona
d = deconvwnr(a,maska);     % dekonwolucja winera
e = deconvreg(a, maska);    % dekonwolucja regularyzowana

subplot(221), imshow(b), title('dek. ślepa');
subplot(222), imshow(c), title('dek. lucy-richaldsona');
subplot(223), imshow(d), title('dek. wienera');
subplot(224), imshow(e), title('dek. regularyzowana');

%% Obrazy III - Szum
close all; clear; clc
a = imread("cameraman.tif");
b = imnoise(a,'gaussian');
c = imnoise(a,'poisson');
d = imnoise(a,'salt & pepper');
e = imnoise(a,'speckle');

subplot(221), imshow(b), title('gaussian');
subplot(222), imshow(c), title('poisson');
subplot(223), imshow(d), title('salt & pepper');
subplot(224), imshow(e), title('speckle');



%% ZADANIE 1
close all; clear; clc;
a = zeros(200,200);
a(50:150,90:110) = 1;
a(90:110,50:150) = 1;
maska = [1 1 1; 0 0 0; -1 -1 -1];
rogi = abs(imfilter(a,maska)).*abs(imfilter(a,maska'));
imshow(rogi)

%% ZADANIE 2 
a = imread("pout.tif");
b = imadjust(a,[0.3;0.8],[0.1,0.95])
szum1 = imnoise(b, 'gaussian');
szum2 = imnoise(b, 'poisson');
szum3 = imnoise(b, 'salt & pepper');
szum4 = imnoise(b, 'speckle');
figure;
subplot(221), imshow(a);
subplot(222), imhist(a);
subplot(223), imshow(b);
subplot(224), imhist(b);
figure;
subplot(221), imshow(szum1);
subplot(222), imshow(szum2);
subplot(223), imshow(szum3);
subplot(224), imshow(szum4);

%% ZADANIE 3 
close all; clear; clc;
a = imread("peppers.png");
b = a;

filtr = fspecial('gaussian', [5 5], 1);
b(:,:,1) = imfilter(b,filtr);
filtr = fspecial('gaussian', [9 9], 2);
b(:,:,2) = imfilter(b,filtr);
filtr = fspecial('gaussian', [13 13], 2.5);
b(:,:,3) = imfilter(b,filtr);

subplot(121), imshow(a);
subplot(122), imshow(b);

%% ZADANIE 4
close all; clear; clc;
a = imread("circles.png");
a = im2double(a);
b = a;
maska1 = fspecial('gaussian', [5 5], 1);
b = imfilter(b,maska1,'same');
maska2 = fspecial('gaussian', [9 9], 2);
b = imfilter(b,maska2,'same');
maska3 = fspecial('gaussian', [13 13], 2.5);
b = imfilter(b,maska3,'same');

dek = deconvwnr(b, maska3);
dek = deconvreg(b, maska3);

figure;
subplot(121), imshow(a);
subplot(122), imshow(b);
figure;
subplot(121), imshow(a);
subplot(122), imshow(dek);