x = [-2*pi:0.1:2*pi];
y = my_fun2(x)
yp = my_fun2p(x)
yp2_05 = secondDer2order(@my_fun2, x, 0.5)
yp2_01 = secondDer2order(@my_fun2, x, 0.1)
yp4_05 = secondDer4order(@my_fun2, x, 0.5)
yp4_01 = secondDer4order(@my_fun2, x, 0.1)

function [y] = my_fun2(x)
    for i=1:length(x)
        y(i)=(1/3)*sin(3*x(i))*exp(-(x(i)^2));
    end
end

function [y] = my_fun2p(x)
    for i=1:length(x)
        y(i) = 1/3*exp(-1*x(i)^2)*((4*x(i)^2-11)*sin(3*x(i))-12*x(i)*cos(3*x(i)));
    end
end

function [y] = secondDer2order(fun, x, h)
    for i=1:length(x)
        y(i)=(1/h^2)*(fun(x(i)+h)-2*fun(x(i))+fun(x(i)-h));
    end
end

function [y] = secondDer4order(fun, x, h)
    for i=1:length(x)
        y(i) = (-1*fun(x(i)-2*h)+16*fun(x(i)-h)-30*fun(x(i))+16*fun(x(i)+h)-fun(x(i)+2*h))/(12*h^2);
    end
end
