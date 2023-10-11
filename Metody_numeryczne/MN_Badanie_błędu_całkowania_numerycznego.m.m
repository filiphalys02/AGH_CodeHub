y = @(x) 1/3.*(exp(-x.^2)).*(x.^3);
x = [-5:0.01:5];
plot(x, y(x))
legend("y")

%calka_y = @(s)-1/6*(exp(-(s^2)))*(s^2+1)
val_c = 0.1514
krok = 1;
wektor = ones(1,10);
for i=1:10
    wektor(:,i+1) = wektor(:,i)/2  ;
end

val_t = integral_trapez(y, 0, 2, 0.125)
val_p = integral_rectangle(y, 0, 2, 0.125)

function [calka_1] = integral_rectangle(fun, a, b, h)
    n = (b-a)/h;
    x = zeros(1,n);
    for i = 1:length(x)
        x(i) = a+h*(i-1);   
    end
    for i = 1:length(x)
        y(i) = fun(x(i));
    end
    calka_1 = sum(y)*h;
end

function [calka_2] = integral_trapez(fun, a, b, h)
    n = (b-a)/h+1;
    x = zeros(1,n);
    for i=1:length(x)
        x(i) = a+h*(i-1);
    end
    for i=1:length(x)
        y(i) = fun(x(i));
    end
    calka_2 = h*(y(1)+y(n))/2+sum(y(2:n-1))*h;
end
