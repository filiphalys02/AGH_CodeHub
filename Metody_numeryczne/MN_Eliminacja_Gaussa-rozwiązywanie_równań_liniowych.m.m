A = [-1,2,1;1,-3,-2;3,-1,-1];
B = [-1;-1;4];
rng(42)
G = randi([-30,30], 6, 6);
d= randi([-78, 78], 6, 1);
Y = determinant(A,B)
m = determinant(G,d)

function [wynik] = determinant(a,b)
    x = [a,b];
    m = size(x,1);
    n = size(x,2);
    for j = 1:(n-1);
        for i = j+1:m;
            pom = x(i,j)/x(j,j);
            for f = j:n;
                x(i,f)=x(i,f) - pom*x(j,f);
            end
        end 
    end
    
    wynik = zeros(m,1);
    for i = m:-1:1
        suma = 0;
        for j = i+1:m
            suma = suma + x(i,j)*wynik(j);
        end
        wynik(i) = (x(i,n)- suma)/x(i,i);
    end
end
