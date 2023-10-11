[x1, iter, x_all] = stycznych(@fun, @pochodna, 0, 6, 0.01, 4)
x=[0:0.1:6];

hold on
plot(x, fun(x))
%plot(x, pochodna(x))
plot(x1, fun(x1), 'og')
plot(x_all, fun(x_all), 'xr')
legend('f(x)=exp(-x)+sin(2x+pi/3)', 'miejsce zerowe', 'kolejne iteracje')

function [y] = fun(x)
    y = exp(-x)+sin(2*x + pi/3);
end

function [y] = pochodna(x)
    y = -exp(-x)+2*cos(2*x + pi/3);
end

function [x1, iter, x_all] = stycznych(fun, pochodna, a, b, eps, x0)
    iter = 1;
    x_all = [];
    x1 = x0 - fun(x0)/pochodna(x0);
    x_all = [x_all, x1];

    while abs(fun(x1))>eps;
        iter = iter + 1;
        x0 = x1;
        x1 = x0 - fun(x0)/pochodna(x0);
        x_all = [x_all, x1];
    end
end
