close all; clear; clc;

plik = ls('.\audio\single-notes\*.mp3');

Np = size(plik, 1);

wys = zeros(Np, 1)';

for k = 1 : Np
    [a, Fs] = audioread(['audio\single-notes\', plik(k,:)]);
    x = a(:,1);
    WA = abs(fft(x));
    N = length(x);
    f = linspace(0, Fs, N);
    WA = WA .* (f'<Fs/2);
    nr = find(WA == max(WA), 1, 'first');
    wys(k) = f(nr);
end

wys';



[a, Fs] = audioread('audio\3-single-notes\C-G-F#.mp3');
x = a(:,1);
prop = audioFeatureExtractor('SampleRate', Fs, 'SpectralDescriptorInput', 'linearSpectrum', 'pitch', true, 'spectralFlux', true);
wyn = extract(prop, x);
info(prop);

[wart, gdzie] = findpeaks(wyn(:,1), 'MinPeakHeight', 0.025, 'MinPeakDistance',20);
g = [gdzie; gdzie(3)+50];

for k = 1 : 3
    ton = median(wyn(g(k):g(k+1),2))
    odl = abs(wys-ton);
    nr(k) = find(odl==min(odl), 1, 'first');
    plik(nr(k), :);
end

subplot(211), plot(wyn(:,1));
subplot(212), plot(wyn(:,2));