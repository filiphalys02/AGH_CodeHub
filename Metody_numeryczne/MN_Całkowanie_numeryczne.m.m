funkcja_1 = @(x)x^2-4;
funkcja_2 = @(x)x^2;

t04 = integral_trapez(funkcja_1, 0, 4, 0.01)
p24 = integral_rectangle(funkcja_1, 2, 4, 0.01)
y = integral_rectangle(funkcja_2, 0, 10, 2)

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
