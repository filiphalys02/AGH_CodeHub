y_prim = @(x,y) (y-x^2);
y = @(x) x^2+2*x-exp(x)+2;
%funkcja_testowa = @(x,y) x/y;
%rozniczka_test = @(x)
%algorytm_eulera = y(i-1) + h * yp(iks(i-1), y(i-1));

eu_19 = rrz_euler(y_prim, 0, 2, 0.1, 0, 1);
eu_19 = eu_19(end-1)

tr_19 = rrz_trapez(y_prim, 0, 2, 0.1, 0, 1);
tr_19 = tr_19(end-1)

rk_19 = rrz_rk(y_prim, 0, 2, 0.1, 0, 1);
rk_19 = rk_19(end-1)

an_19 = y(1.9)

function [y] = rrz_euler(fun, a,b,h,x0,y0)
 iks = [a:h:b]';
 n=length(iks);
 y = zeros(n,1);
 y(1) = y0;
 for i=2:n
 y(i) = y(i-1) + h * fun(iks(i-1), y(i-1));
 end
end


function [y] = rrz_trapez(fun, a,b,h,x0,y0)
iks = [a:h:b]';
 n=length(iks);
 y = zeros(n,1);
 y(1) = y0;
 for i=2:n
 y(i) = y(i-1) + (h/2) * (fun(iks(i-1),y(i-1)) + fun(iks(i),y(i-1))+h*fun(iks(i-1),y(i-1)));
 %y(i) = y(i) + (h/2) * (fun(iks(i),y(i)) + fun(iks(i+1),y(i)+h*fun(iks(i),y(i)));
 end
 end
 
 
function [y] = rrz_rk(fun, a,b,h,x0,y0)
iks = [a:h:b]';
 n=length(iks);
 y = zeros(n,1);
 y(1) = y0;
 for i=2:n
    k1 = h* (fun(iks(i-1), y(i-1)));
    k2 = h* (fun(iks(i-1) + (1/2)*h, y(i-1)+(1/2)*k1));
    k3 = h* (fun(iks(i-1) + (1/2)*h, y(i-1)+(1/2)*k2));
    k4 = h* (fun(iks(i-1) + h, y(i-1)+k3));
    y(i) = y(i-1)+(1/6)*(k1+2*k2+2*k3+k4);

 end
 end
