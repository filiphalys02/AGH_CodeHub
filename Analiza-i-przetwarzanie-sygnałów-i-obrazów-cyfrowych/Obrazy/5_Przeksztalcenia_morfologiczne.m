%% Obrazy V - Element strukturalny
close all; clear; clc;
% Przykładowe SE wykonane funkcją strel(), można ich używać we wszystkich poniższych zadaniach
SE1 = strel('arbitrary', [1 2 3; 1 2 3; 1 2 3]); % NHOOD
SE2 = strel('diamond', 17);                      % Offset
SE3 = strel('disk',5);                           % Disk
SE4 = strel('rectangle', [6 6]);                 % Prostokąt
SE5 = strel('line',17,45);                       % Linia
SE6 = strel('square', 5);                        % Kwadrat
SE7 = strel('octagon', 4);                       % Ośmiokąt

%% Obrazy V - Erozja
close all; clear; clc;
a = imread("circles.png");
SE = [1 1 1; 1 1 1; 1 1 1];
SE = [1 0 0; 0 1 0; 0 0 1];
SE = [1 1 1];
SE = [1; 1; 1];
e = imerode(a,SE);
subplot(121), imshow(a);
subplot(122), imshow(e)

%% Obrazy V - Dylatacja
close all; clear; clc;
a = imread("circles.png");
%SE = [x x x; x 0 x; x x x]
SE = [1 1 1; 0 0 0; 0 0 0];
SE = [0 0 0; 0 0 0; 1 1 1];
SE = [1 0 0; 1 0 0; 1 0 0];
SE = [0 0 1; 0 0 1; 0 0 1];
d = imdilate(a,SE);
subplot(121), imshow(a);
subplot(122), imshow(d);

%% Obrazy VI - Otwarcie i zamknięcie
close all; clear; clc;
a = imread("circles.png");
SE = ones(3);
o = imopen(a, SE);
z = imclose(a,SE);
subplot(121), imshow(o);
subplot(122), imshow(z);

%% Obrazy VI - Tophat i Bothat
close all; clear; clc;
a = imread("circles.png");
SE = ones(10,10);
t = imtophat(a,SE);
b = imbothat(a,SE);
subplot(121), imshow(t);
subplot(122), imshow(b);

%% Obrazy VII - Czyszczenie krawędzi, wypełnianie środka
close all; clear; clc;
a = imread('blobs.png');
b = imclearborder(a);
c = imfill(a,'holes');
subplot(131), imshow(a);
subplot(132), imshow(b);
subplot(133), imshow(c);




