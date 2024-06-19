A = [6,4,1;1,-3,-1;1,-1,-4];
B = [11;-3;-4];
D = zeros(size(A));
X0 = [2;0;-2];
for i = 1: size(A)
    D(i,i) = A(i,i);
end
R = A - D;
W = -(D^-1*R);
Z = D^-1*B;
EPS1 = 0.001;
EPS2 = 0.00001;
E1 = ones(size(X0)) * EPS1;
E2 = ones(size(X0)) * EPS2;

P1 = abs(W);
w1 = max(sum(P1,2))
w2= max(sum(abs(W),1))
w3 =sqrt(sum(sum(W.*W),2))

if w1<1 || w2<1 || w3<1
    "warunek spelniony"
    [X1, it1] = funkcja(W,Z,X0,E1)
    [X2, it2] = funkcja(W,Z,X0,E2)
else 
    "nie mozna liczyc ta metoda"
end

function[xi, it] = funkcja(w,z,x0,eps)
    wektorroznic = ones(length(x0));
    it=0;
    while any(abs(wektorroznic) > eps)
        xi = w*x0 + z;
        wektorroznic = xi - x0;
        x0 = xi;
        it = it + 1;
    end
    %xi = xi - ones(size(x0));
end
