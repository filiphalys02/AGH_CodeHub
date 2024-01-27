%% ZAD. 1a
close all; clear; clc
Fs = 100;
t = -pi : 1/Fs : pi;
x = 1 .*(t>=-1&t<=1);
XT = fft(x);
XT = fftshift(XT);
WA = abs(XT);
WF = angle(XT);
f = linspace(-Fs/2,Fs/2,length(t));
subplot(311), plot(t,x);
subplot(312), plot(f,WA);
subplot(313), plot(f,WF);

%% ZAD. 1b
close all; clear; clc
Fs = 100;
t = -5 : 1/Fs : 5;
x = (1-abs(t)).*(t>=-1&t<=1);
XT = fft(x);
XT = fftshift(XT);
WA = abs(XT);
WF = angle(XT);
f = linspace(-Fs/2,Fs/2,length(t));
subplot(311), plot(t,x);
subplot(312), plot(f,WA);
subplot(313), plot(f,WF);

%% ZAD. 1c
close all; clear; clc
Fs = 100;
t = -4*pi : 1/Fs : 4*pi;
x = sin(2*pi*t);
XT = fftshift(fft(x));
WA = abs(XT);
WF = angle(XT);
f = linspace(-Fs/2,Fs/2,length(t));
subplot(311), plot(t,x);
subplot(312), plot(f,WA);
subplot(313), plot(f,WF);

%% ZAD. 1d
close all; clear; clc
Fs = 100;
t = -5 : 1/Fs : 5;
x = exp((-(t.^2))/2);
XT = fftshift(fft(x));
WA = abs(XT);
WF = angle(XT);
f = linspace(-Fs/2,Fs/2,length(t));
subplot(311),plot(t,x);
subplot(312),plot(f,WA);
subplot(313),plot(f,WF);

%% ZAD. 2a
close all; clear; clc
x = [1,0,-2,1];
XT = fft(x)
WA = abs(XT)

%% ZAD. 2b
close all; clear; clc
x = [1+1i,2-1i,3,i];
XT = fft(x)
WA = abs(XT)

%% ZAD. 2c
close all; clear; clc
x = [1,2,3,4];
XT = fft(x)
WA = abs(XT)

%% ZAD. 2d
close all; clear; clc
x = [1+1i,1-1i,2+1i,2-1i];
XT = fft(x)
WA = abs(XT)