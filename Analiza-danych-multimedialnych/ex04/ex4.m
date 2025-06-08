close all; clear; clc;
load mtlb.mat
x = mtlb';
przes = 0.25;
skala = 0.6;
dt = round(przes*Fs);
echo = [x, zeros(1, dt)] + skala*[zeros(1, dt), x];
N = length(x);
Ne = length(echo);
t = (0:N-1)/Fs;
te = (0:Ne-1)/Fs;
subplot(211), plot(te, echo, 'g', t, x, 'r');
xc = xcorr(echo, echo);
tc = (-Ne+1:Ne-1)/Fs;
subplot(212), plot(tc, xc);
rc = rceps(echo);
plot(rc);
[wart, gdzie] = findpeaks(rc, 'MinPeakHeight', 0.2);
IIR = [1, zeros(1, gdzie(2)-2), 2*wart(2)];
xn = filter(1, IIR, echo);
plot(te, xn);

%%
close all; clear; clc;
load huk.mat

FB = zeros(9, 1);
v=340;

for k = 1 : 9
    b = imclose(a(k,:).^2, ones(1,45));
    FB(k,1) = find(b>=0.2, 1, 'first');
end

FB = (FB-1)/Fs;
SP = mean(poz);
t_FB = mean(FB);

for n = 1 : 5000
    SP2 = ones(9,1)*SP;
    dyst = sqrt(sum((SP2-poz)'.^2))';
    G = ones(9,4);
    for k = 1 : 3
        G(:,k) = (SP2(:, k)-poz(:,k))./dyst;
    end
    d = (FB-t_FB)-dyst/v;
    m = pinv(G)*d;
    SP = SP + m(1:3)'
    t_FB = t_FB + m(4);
end

plot3(poz(:,1), poz(:,2), poz(:,3), 'ok'); hold on
plot3(SP(1), SP(2), SP(3), '*r'); hold off
axis equal