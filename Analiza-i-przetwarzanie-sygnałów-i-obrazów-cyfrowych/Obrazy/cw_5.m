close all; clear; clc;
SE1 = strel('disk',5);
SE2 = strel('line',11,30);
SE3 = [1 0 1; 1 0 1; 1 1 1; 1 0 1; 1 0 1];
%a = imread('circles.png');
%a = imread('cameraman.tif');
%a = imread('blobs.png');
%a1 = imerode(a,SE1);
%a2 = imerode(a,SE2);
%a3 = imerode(a,SE3);
%a1 = imdilate(a,SE1);
%a2 = imdilate(a,SE2);
%a3 = imdilate(a,SE3);
%a1 = imopen(a,SE1);
%a2 = imopen(a,SE2);
%a3 = imopen(a,SE3);
%a1 = imclose(a,SE1);
%a2 = imclose(a,SE2);
%a3 = imclose(a,SE3);
subplot(221), imshow(a);
subplot(222), imshow(a1);
subplot(223), imshow(a2);
subplot(224), imshow(a3);

%% 
close all; clear; clc;
a = imread('circles.png');
SE = ones(3);
a1 = imdilate(a,SE)-a;
a2 = a - imerode(a,SE);
a3 = a1+a2;
subplot(221), imshow(a);
subplot(222), imshow(a1);
subplot(223), imshow(a2);
subplot(224), imshow(a3);

%%
close all; clear; clc;
a = imread('blobs.png');
b = imclearborder(a);
b = imfill(a,'holes');
subplot(121), imshow(a);
subplot(122), imshow(b);

%%
close all; clear; clc;
a = imread('dziury.bmp');
imshow(a);
SE = true(3);
marker = false(size(a));
iter = 0;
marker(23,234)=true;

while ~marker(83,260)
    marker = imdilate(marker,SE) & a;
    iter = iter + 1;
end
iter


%%
close all; clear; clc;
a = false(200);
a(91:110,46:155)=true;
a(61:140,106:125)=true;
imshow(a);
SE1 = [1 1 0; 1 -1 0; 1 0 -1];
SE2 = [1 1 1; 1 -1 0; 0 -1 0];
b = false(200);
while ~isequal(a,b)
    b=a;
    for k=1:4
        a = a | bwhitmiss(a,SE1);
        a = bwmorph(a,'clean');
        a = a | bwhitmiss(a,SE2);
        SE1 = rot90(SE1);
        SE2 = rot90(SE2);
    end
end

%% 
close all; clear; clc;
a = imread('circles.png');
a1 = bwmorph(a,'thin',Inf);
a2 = bwmorph(a,'erode',Inf); %thicken - pogrubianie
a3 = bwmorph(a,'skel',Inf);
subplot(221), imshow(a);
subplot(222), imshow(a1);
subplot(223), imshow(a2);
subplot(224), imshow(a3);


        
    




