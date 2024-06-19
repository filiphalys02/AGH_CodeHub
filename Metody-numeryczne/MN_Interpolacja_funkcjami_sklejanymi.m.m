x=-5:0.01:5;

for i=1:length(x)
    y_runge(i)=1/(1+x(i)^2);
end

x2=wezly(2);
y2=igreki_wezly(x2);
x4=wezly(4);
y4=igreki_wezly(x4);
x6=wezly(6);
y6=igreki_wezly(x6);
x8=wezly(8);
y8=igreki_wezly(x8);
x10=wezly(10);
y10=igreki_wezly(x10);

for i=1:length(x)
    y_Lagrange_2(i)=interp_lagrange(x2, y2, x(i));
end
for i=1:length(x)
    y_Lagrange_4(i)=interp_lagrange(x4, y4, x(i));
end
for i=1:length(x)
    y_Lagrange_6(i)=interp_lagrange(x6, y6, x(i));
end
for i=1:length(x)
    y_Lagrange_8(i)=interp_lagrange(x8, y8, x(i));
end
for i=1:length(x)
    y_Lagrange_10(i)=interp_lagrange(x10, y10, x(i));
end
y_spline_2=interp1(x2, y2, x, 'spline');
y_spline_4=interp1(x4, y4, x, 'spline');
y_spline_6=interp1(x6, y6, x, 'spline');
y_spline_8=interp1(x8, y8, x, 'spline');
y_spline_10=interp1(x10, y10, x, 'spline');

figure(1)
subplot(2, 3, 1)
plot(x, y_runge)
title('Funkcja Rungego')
xlabel('x')
ylabel('y')
subplot(2, 3, 2)
plot(x2, y2, 'o')
hold on
plot(x, y_Lagrange_2)
title('Interpolacja Lagrange n=2')
xlabel('x')
ylabel('y')
subplot(2, 3, 3)
plot(x4, y4, 'o')
hold on
plot(x, y_Lagrange_4)
title('Interpolacja Lagrange n=4')
xlabel('x')
ylabel('y')
subplot(2, 3, 4)
plot(x6, y6, 'o')
hold on
plot(x, y_Lagrange_6)
title('Interpolacja Lagrange n=6')
xlabel('x')
ylabel('y')
subplot(2, 3, 5)
plot(x8, y8, 'o')
hold on
plot(x, y_Lagrange_8)
title('Interpolacja Lagrange n=8')
xlabel('x')
ylabel('y')
subplot(2, 3, 6)
plot(x10, y10, 'o')
hold on
plot(x, y_Lagrange_10)
title('Interpolacja Lagrange n=10')
xlabel('x')
ylabel('y')

figure(2)
subplot(2, 3, 1)
plot(x, y_runge)
title('Funkcja Rungego')
xlabel('x')
ylabel('y')
subplot(2, 3, 2)
plot(x2, y2, 'o')
hold on
plot(x, y_spline_2)
title('Interpolacja splajnami n=2')
xlabel('x')
ylabel('y')
subplot(2, 3, 3)
plot(x4, y4, 'o')
hold on
plot(x, y_spline_4)
title('Interpolacja splajnami n=4')
xlabel('x')
ylabel('y')
subplot(2, 3, 4)
plot(x6, y6, 'o')
hold on
plot(x, y_spline_6)
title('Interpolacja splajnami n=6')
xlabel('x')
ylabel('y')
subplot(2, 3, 5)
plot(x8, y8, 'o')
hold on
plot(x, y_spline_8)
title('Interpolacja splajnami n=8')
xlabel('x')
ylabel('y')
subplot(2, 3, 6)
plot(x10, y10, 'o')
hold on
plot(x, y_spline_10)
title('Interpolacja splajnami n=10')
xlabel('x')
ylabel('y')

igrek10s=y_spline_10;
igrek10l=y_Lagrange_10;

function [wezel]=wezly(n)
for i=0:n
    wezel(i+1)=-5+i*10/n;
end
end

function [y]=igreki_wezly(x)
for i=1:length(x)
    y(i)=1/(1+x(i)^2);
end
end

function [igrek]=interp_lagrange(x, y, iks)
n=length(x);
wynik=0;
for i=1:n
    licznik=1;
    mianownik=1;
    for k=1:n
        if(k~=i)
            licznik=licznik*(iks-x(k));
            mianownik=mianownik*(x(i)-x(k));
        end
    end
    iloraz=licznik/mianownik;
    wynik=wynik+y(i)*iloraz;
    igrek=wynik;
end
end
