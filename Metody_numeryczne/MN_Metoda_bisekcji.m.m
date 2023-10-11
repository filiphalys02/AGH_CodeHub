a = 0;
b = 2;
eps = 0.01;
y = @(x) (exp(-x)) + sin(2*x+pi/3);
[x1, iter] = bisekcja(y, a, b, eps)

function [x, iter] = bisekcja(fun, a, b, eps)
    Y=1;
    iter=0;
    while((abs(b-a) > eps) | (fun(x)==0))
        iter = iter + 1;
        x = (a+b)/2;
        Y = fun(x);
        if(fun(a)*Y>0)
            a = x;
        else
            b = x;
        end
        if (x==0)
            print("x jest pierwiastkiem");
        end
    end
end
