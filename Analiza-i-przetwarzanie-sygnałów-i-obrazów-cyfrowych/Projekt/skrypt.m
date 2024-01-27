%% MIKI
close all; clear; clc;
a   = imread("B_11\XN_60.jpg"); % Wczytanie obrazu
a_r = a(:,:,1);                 % Wyodrębnienie składowych RGB 
a_g = a(:,:,2);
a_b = a(:,:,3);

bin = a_r > 200 & a_g > 200 & a_b > 200; % Binaryzacja obrazu 
bin = imclose(bin, ones(5));             % Zamknięcie w celu połączenia obiektów   
bin = bwareaopen(bin,140);               % Usunięcie małych elementów
bin = imclose(bin, ones(7));             % Wypełnienie dziur

skala  = 1010-75;           % Ilość pikseli na 500 unimetrów
piksel = 500/skala;         % Długość 1 pisela
pole_p = piksel*piksel;     % Pole 1 piksela
jednostka = 0.001*0.001;    % Konwersja jednostek
mika = sum(bin(:)) * pole_p * jednostka % Obliczenie pola wynikowego

imshow(bin)

%% GLAUKONIT
close all; clear; clc;
a = imread("B_11\1N_0.jpg"); % Wczytanie obrazu
a = rgb2hsv(a);              % Konwersja z RGB do HSV
a_h = a(:,:,1);              % Wyodrębnienie składowych HSV 
a_s = a(:,:,2);
a_v = a(:,:,3);
bin = a_h>0.19 & a_h<0.55 & a_v>0.25 & a_v<0.55; % Binaryzacja
bin = bwareaopen(bin,100);                       % Usunięcie małych elementów
bin = imclose(bin, ones(9));                     % Połączenie elementów
bin = imclearborder(bin);                        % Usunięcie elementów brzegowych
bin = bwareaopen(bin,1000);                      % Usunięcie reszty elementów

skala  = 1010-75;           % Ilość pikseli na 500 unimetrów
piksel = 500/skala;         % Długość 1 pisela
pole_p = piksel*piksel;     % Pole 1 piksela
jednostka = 0.001*0.001;    % Konwersja jednostek
glaukonit = sum(bin(:)) * pole_p * jednostka % Obliczenie pola wynikowego

imshow(bin)

%% KWARC
close all; clear; clc;
a = imread("B_11/1N_0.jpg");    % Wczytanie obrazu
a = rgb2hsv(a);                 % Konwersja z RGB do HSV
a_h = a(:,:,1);                 % Wyodrębnienie składowych HSV
a_s = a(:,:,2);
a_v = a(:,:,3);

bin = a_v>0.46 & a_h>0.60;      % Binaryzacja
bin = imclose(bin,strel("disk",5)); % Łączenie pikseli
bin = bwareaopen(bin, 200);     % Usuwanie małych obiektów
bin = imclose(bin,ones(7));     % Zamknięcie zatok
bin = imfill(bin, 'holes');     % Wypełnienie dziur

skala  = 1010-75;           % Ilość pikseli na 500 unimetrów
piksel = 500/skala;         % Długość 1 pisela
pole_p = piksel*piksel;     % Pole 1 piksela
jednostka = 0.001*0.001;    % Konwersja jednostek
kwarc = sum(bin(:)) * pole_p * jednostka % Obliczenie pola wynikowego

imshow(bin)