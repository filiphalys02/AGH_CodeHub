x = [1,2,3];
y = [0,1,4];
iksCheck = [2:0.1:4];
igrekCheck = [2:0.1:4];
suma = 0;

for i = 1:max(size(igrekCheck))
    suma = suma + interp_lagrange(x,y,iksCheck(i));
end
suma_igrek = suma
function [igrek] = interp_lagrange(x,y,iks)
    n = length(x);
    igrek = 0;
    for i = 1:n
        mianownik = 1;
        licznik = 1;
        for k = 1:n
            if (k ~= i)
                licznik = licznik*(iks - x(k));
                mianownik = mianownik*(x(i) - x(k));
            end
        end
        iloraz = licznik/mianownik;
        igrek = igrek + y(i)*iloraz;
    end
end

daneG = load('G.txt');
daneH = load('H.txt');
G_x = daneG(1,:);
G_y = daneG(2,:);
H_x = daneH(1,:);
H_y = daneH(2,:);
iks = -9:0.1:9;

g=interp_lagrange(G_x,G_y,iks);
h=interp_lagrange(H_x,H_y,iks)

plot(G_x,G_y,'ko:')
hold on;
plot(iks,g)
hold on;
plot(H_x,H_y,"rs")
hold on;
plot(iks,h)
title("Interpolacja Lagrange'a")
xlabel('x')
ylabel('y')
legend('G(x)', 'H(x)')

for i=1:length(iks)
    if iks(i)==-8.8
        g_8_8 = g(i)
    end
end
for i=1:length(h)
    if iks(i)==-8.8
        h_8_8 = h(i)
    end
end

function [igrek] = interp_lagrange(x,y,iks)
    for j = 1:length(iks)
        iloraz=0;
        w=0;
        for i = 1:length(y)
            licznik=1;
            mianownik=1;
            for k = 1:length(x)
                if(k ~= i)
                licznik = licznik*(iks(j)-x(k));
                mianownik = mianownik*(x(i)-x(k));
                end
            end
            iloraz = licznik/mianownik;
            w = w + y(i)*iloraz;
        end
        igrek(j) = w;
    end
end
