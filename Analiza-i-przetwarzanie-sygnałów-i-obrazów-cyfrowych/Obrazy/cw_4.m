%% transformaty (cosinusowa) dct2 idct2
close all; clear; clc;
a = imread("cameraman.tif");
a = double(a)/255;
subplot(121), imshow(a);
A = dct2(a);
subplot(122), imagesc(log(abs(A)+0.01));axis image

[Nz, Nx]=size(a);
fx = 0 : Nx-1;
fz = 0 : Nz-1;
[FX, FZ] = meshgrid(fx, fz);
f = sqrt(FX.^2 + FZ.^2);
%imagesc(f);
r = [5 20 50 100];
figure;
for k = 1 : 4
    LP = f<=r(k);
    an = idct2(LP .* A);
    subplot(2,2,k), imshow(an);
end

%% tablice kodowe
close all; clear; clc;
Qy = [16 11 10 16 24 40 51 61
12 12 14 19 26 58 60 55
14 13 16 24 40 57 69 56
14 17 22 29 51 87 80 62
18 22 37 56 68 109 103 77
24 35 55 64 81 104 113 92
49 64 78 87 103 121 120 101
72 92 95 98 112 100 103 99];

Qc = [17 18 24 47 99 99 99 99
18 21 26 66 99 99 99 99
24 26 56 99 99 99 99 99
47 69 99 99 99 99 99 99
99 99 99 99 99 99 99 99
99 99 99 99 99 99 99 99
99 99 99 99 99 99 99 99
99 99 99 99 99 99 99 99];

a = imread("peppers.png");
[Nz, Nx,~]=size(a);
b = rgb2ycbcr(a);
b = double(b)-128;


for kz = 1 : 8 : Nz
    for kx = 1 : 8 : Nx
        for k = 1 : 3
            tt = b(kz:kz+7, kx:kx+7, k);
            tt = dct2(tt);
            % kompozycja
            if k==1
                tt = tt./Qy;
            else
                tt = tt./Qc;
            end
            tt = round(tt);
            % dekompozycja
            if k==1
                tt = tt.*Qy;
            else
                tt = tt.*Qc;
            end
            tt = idct2(tt);
            b(kz:kz+7, kx:kx+7, k)=tt;
        end
    end
end
b = uint8(b+128);
b = ycbcr2rgb(b);
subplot(121), imshow(a);
subplot(122), imshow(b);

%% zmiana qc i gy
close all; clear; clc;
Qy = [16 11 10 16 24 40 51 61
12 12 14 19 26 58 60 55
14 13 16 24 40 57 69 56
14 17 22 29 51 87 80 62
18 22 37 56 68 109 103 77
24 35 55 64 81 104 113 92
49 64 78 87 103 121 120 101
72 92 95 98 112 100 103 99];

Qc = [17 18 24 47 99 99 99 99
18 21 26 66 99 99 99 99
24 26 56 99 99 99 99 99
47 69 99 99 99 99 99 99
99 99 99 99 99 99 99 99
99 99 99 99 99 99 99 99
99 99 99 99 99 99 99 99
99 99 99 99 99 99 99 99];

Qc = Qc * 1; % zmiana cyfry
Qy = Qy * 1; % zmiana cyfry

a = imread("peppers.png");
[Nz, Nx,~]=size(a);
b = rgb2ycbcr(a);
b = double(b)-128;


for kz = 1 : 8 : Nz
    for kx = 1 : 8 : Nx
        for k = 1 : 3
            tt = b(kz:kz+7, kx:kx+7, k);
            tt = dct2(tt);
            % kompozycja
            if k==1
                tt = tt./Qy;
            else
                tt = tt./Qc;
            end
            tt = round(tt);
            % dekompozycja
            if k==1
                tt = tt.*Qy;
            else
                tt = tt.*Qc;
            end
            tt = idct2(tt);
            b(kz:kz+7, kx:kx+7, k)=tt;
        end
    end
end
b = uint8(b+128);
b = ycbcr2rgb(b);
subplot(121), imshow(a);
subplot(122), imshow(b);

%% transformacja Hougha
close all; clear; clc;
a = imread("blobs.png");
subplot(121), imshow(a);
[H,T,R] = hough(a);
piki = houghpeaks(H,10);
L = houghlines(a,T,R,piki,'FillGap',5);
subplot(122), imagesc(T,R,H);
subplot(121), imshow(a); hold on
max_odl = 0;
for k = 1 : 10
    line([L(k).point1(1), L(k).point2(1)], [L(k).point1(2), L(k).point2(2)], 'color', 'r');
    odl = sqrt( (L(k).point1(1)-L(k).point2(1)).^2 + (L(k).point1(2)-L(k).point2(2)).^2 )
    if odl>max_odl
        max_odl = odl;
        n = k;
    end
end
hold off
k = n;
    line([L(k).point1(1), L(k).point2(1)], [L(k).point1(2), L(k).point2(2)], 'color', 'b');
