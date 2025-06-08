%%

%---------------------------------------------------------------- ZADANIE 1

clear; close all; clc;

% Wczytanie danych
[a, Fs] = audioread('morning.mp3');

% Odsłuchanie rozmowy
%sound(a, Fs);

% Ekstraktor cech audio
prop = audioFeatureExtractor('SampleRate', Fs, ...
    'SpectralDescriptorInput','barkSpectrum', ...
    'pitch', true, ...
    'spectralFlux', true, ...
    'harmonicRatio', true, ...
    'spectralSpread', true);

% Ekstrakcja cech z prop
wyn = extract(prop, a);

% Tonacja
pitch = wyn(:,3); 

% Okno
window_size = 95;
n_windows = floor(length(pitch) / window_size);

% Wektor na średni pitch dla każdego okna
for i = 1:n_windows
    idx_start = (i-1) * window_size + 1;
    idx_end = i * window_size;
    window = pitch(idx_start:idx_end);
    window = window(window > 0 & ~isnan(window)); 
    if isempty(window)
        avg_pitch(i) = NaN;
    else
        avg_pitch(i) = mean(window);
    end
end

% Wygładzenie avg_pitch medianowym filtrem
smoothed_pitch = medfilt1(avg_pitch, 3, 'omitnan', 'truncate');

% Wykres Pitch dla czasu
t_pitch = (0:length(smoothed_pitch)-1) * (window_size / Fs);
figure;
plot(t_pitch, smoothed_pitch);
xlabel('Czas');
ylabel('Pitch [Hz]');
title('Pitch w czasie');
grid on;

% Rozciągnięcie smoothed_pitch -> każdy element window_size razy
expanded_pitch = repelem(smoothed_pitch, window_size);

% Dopasowanie długości expanded_pitch do długości pitch
if length(expanded_pitch) < length(pitch)
    expanded_pitch(length(pitch)) = NaN;
elseif length(expanded_pitch) > length(pitch)
    expanded_pitch = expanded_pitch(1:length(pitch));
end

% Maska mojego głosu
filip = nan(size(expanded_pitch));

% Przypisanie 1 do mojego głosu
filip(expanded_pitch < 160) = 1;


% Krok przesuwania
hop = 512;

% Lista segmentów do uzupełniania
segments = [];

% Flaga inSpeech
inSpeech = false;

% Wykrywanie początków i końców fragmentów rozmowy 
for i = 1:length(filip)
    if filip(i) == 1 && ~inSpeech
        start = (i - 1) * hop + 1;
        inSpeech = true;
    elseif filip(i) ~= 1 && inSpeech
        finish = (i - 1) * hop + 1;
        segments = [segments; start, finish];
        inSpeech = false;
    end
end

% Jeśli pętla zakończyła się w trakcie mowy, zamyka ostatni segment do końca sygnału
if inSpeech
    finish = length(a);
    segments = [segments; start, finish];
end

% Minimalna długość segmentu - 10 sekund
min_dur = Fs * 10.0; 

% Filtr segmentów, zostawiający tylko te dłuższe niż 10 sekund
segments_filtered = [];
for i = 1:size(segments,1)
    if segments(i,2) - segments(i,1) >= min_dur
        segments_filtered = [segments_filtered; segments(i,:)];
    end
end
segments = segments_filtered;

% Maska logiczna sygnału -> segmenty -> 1
mask = zeros(size(a));
for i = 1:size(segments,1)
    start_idx = segments(i,1);
    finish_idx = min(segments(i,2), length(a));
    mask(start_idx:finish_idx) = 1;
end

% Wydzielenie fragmentów, które należą do segmentów (to co mówi Filip)
filip_audio = a .* mask;

% Utworzenie wektora segment_id z id segmentu dla każdego punktu sygnału
segment_id = zeros(size(a)); 
for i = 1:size(segments,1)
    start_idx = segments(i,1);
    finish_idx = min(segments(i,2), length(a));
    segment_id(start_idx:finish_idx) = i;
end

% Wykres sygnału audio,
t = (0:length(a)-1)/Fs;
figure;
subplot(211), 
plot(t, a.*(~filip_audio), 'r', t, filip_audio, 'b'); 
xlabel('Czas [s]'); 
ylabel('Amplituda'); 
title('Sygnał audio (Niebieski - Filip, Czerwony - Urszula)'); 
grid on;


% Pobranie cechy spectral flux, rozciągnięcie długości sygnału
flux = wyn(:,1); 
flux_full = repelem(flux, hop);
min_len = min(length(flux_full), length(a));
flux_full = flux_full(1:min_len);
a = a(1:min_len);
% Przycięcie wszystkich wektorów do najkrótszej długości
segment_id = segment_id(1:min_len);

% Tablica na czasy wykrytych słów
all_word_times = [];

% Licznik słów dla każdego segmentu
word_counts = zeros(size(segments,1), 1);

% Dla każdego segmentu:
%  - wycięcie fragment flux
%  - wygładzenie go medianowo
%  - wyznaczenie lokalnego progu (0.1*mean + 0.34 * std)
%  - wykrycie pików z minimalną wysokością i minimalnym odstępem 0.24s
%  - zapisanie czasów pików i zliczenie słów
for i = 1:size(segments,1)
    start_idx = segments(i,1);
    finish_idx = min(segments(i,2), length(flux_full));
    flux_segment = flux_full(start_idx:finish_idx);
    flux_segment_smooth = medfilt1(flux_segment, 5);
    local_thresh = 0.1*mean(flux_segment_smooth) + 0.34 * std(flux_segment_smooth);

    [~, locs] = findpeaks(flux_segment_smooth, ...
        'MinPeakHeight', local_thresh, ...
        'MinPeakDistance', round(Fs * 0.24)); 

    abs_locs = start_idx + locs - 1;
    all_word_times = [all_word_times; abs_locs / Fs];

    word_counts(i) = length(locs); 
end

% Wykres sygnału tylko z sygnałem Filipa
t = (0:length(filip_audio)-1)/Fs;
subplot(212), plot(t, filip_audio);
hold on;

% Pionowe linie dla wykrytych słów
for j = 1:length(all_word_times)
    xline(all_word_times(j), 'r', 'LineWidth', 0.5);
end

xlabel('Czas [s]');
ylabel('Amplituda');
title('Sygnał Filipa + słowa');
legend('Sygnał', 'Słowa');
grid on;

% Liczba słów
fprintf('Liczba wykrytych słów w segmentach:');
fprintf('\n');
for i = 1:length(word_counts)
    fprintf('Segment %d: %d słów', i, word_counts(i));
    fprintf('\n');
end
fprintf('\n')
fprintf('Łączna suma wszystkich wykrytych słów: %d', sum(word_counts))
fprintf('\n')

% Rzeczywista liczba słów
words_real = [52, 55, 53]; 

% Procentowy błąd detekcji słów dla każdego segmentu
frag_err = abs(words_real - word_counts') ./ words_real * 100;

% Procentowy błąd i liczby słów rzeczywiste vs wykryte
fprintf('\n');
fprintf('\nBłąd segmentów:\n');
fprintf('\n');
for i = 1:length(words_real)
    fprintf('Segment %d: %f (Rzezcywista ilość słów: %d, Ilość wykrytych słów: %d)', i, frag_err(i), words_real(i), word_counts(i));
    fprintf('\n');
end

% Średni błąd
mean_eerr= sum(frag_err .* words_real) / sum(words_real);

fprintf('\n');
fprintf('\nBłąd średni: %f', mean_eerr);
fprintf('\n');

% Segmenty - początki i końce (w sekundach)
fprintf('\nPoczątki i końce segmentów (w sekundach):\n');
for i = 1:size(segments,1)
    start_sec = segments(i,1) / Fs;
    end_sec = segments(i,2) / Fs;
    fprintf('Segment %d: od %.2f s do %.2f s\n', i, start_sec, end_sec);
end

%%

%---------------------------------------------------------------- ZADANIE 2

%-------------------------------------------------------------------MORNING
close all; clc;
word_starts_m = [];
word_bounds_m = [];

start_idx = segments(1,1);
finish_idx = segments(1,2);

flux_segment = flux_full(start_idx:finish_idx);
flux_segment_smooth = medfilt1(flux_segment, 5);
local_thresh = 0.1 * mean(flux_segment_smooth) + 0.34 * std(flux_segment_smooth);

[~, locs] = findpeaks(flux_segment_smooth, ...
    'MinPeakHeight', local_thresh, ...
    'MinPeakDistance', round(Fs * 0.24)); 

abs_locs = start_idx + locs - 1;
word_starts_m = [word_starts_m; abs_locs];

fprintf('\n\n\n----- AUTOMATYCZNE SEGMENTY -----\n')
for k = 1:length(abs_locs)
    start_w = abs_locs(k);
    
    if k < length(abs_locs)
        end_w = abs_locs(k+1) - 1;
    else
        end_w = min(finish_idx, length(a));  
    end

    word_bounds_m = [word_bounds_m; start_w, end_w]; 

    word_audio = a(start_w:end_w);
    fprintf('Słowo %d (czas: %.2f–%.2f s)\n', k, start_w/Fs, end_w/Fs);
    % sound(word_audio, Fs);
end

% Nadpisanie ręczne czasów
word_bounds_m = [
     1.40,  2.10; % jedzą
     2.20,  2.65; % piją 
     2.67,  3.13; % lulki
     3.15,  3.60; % palą 
     3.70,  4.45; % tańce
     4.52,  5.12; % hulanka
     5.15,  5.75; % swawola
     6.30,  6.70; % ledwie
     6.75,  7.35; % karczmy
     7.38,  7.62; % nie
     7.62,  8.30; % rozwalą
     8.40,  8.80; % ha
     8.85,  9.10; % ha
     9.18,  9.38; % hi
     9.40,  9.70; % hi
     9.80, 10.30; % hejze 
    10.30, 10.65; % hola

    11.40, 12.10; % Twardowski
    12.18, 12.68; % siadł  
    12.70, 12.85; % w
    12.90, 13.21; % końcu
    13.23, 13.70; % stoła
    14.15, 14.60; % podparł
    14.60, 14.75; % się
    14.75, 14.90; % w
    14.90, 15.15; % boki
    15.15, 15.34; % jak 
    15.34, 15.90; % basza
    16.40, 16.80; % hulaj
    16.85, 17.40; % dusza
    17.45, 17.90; % hulaj
    17.93, 18.40; % woła
    18.55, 19.24; % śmieszy
    19.30, 19.80; % tumani
    19.87, 20.60; % przestrasza

    21.30, 21.95; % Żołnierzowi
    21.95, 22.05; % co 
    22.15, 22.40; % grał 
    22.40, 22.95; % zucha
    23.30, 23.85; % Wszystkich 
    23.90, 24.40; % łaje 
    24.45, 24.67; % i 
    24.68, 25.40; % potrąca
    25.80, 26.27; % Świsnął 
    26.27, 26.77; % szablą 
    26.80, 27.18; % koło 
    27.28, 27.60; % ucha
    28.00, 28.34; % Już 
    28.34, 28.52; % z 
    28.58, 29.60; % żołnierza 
    29.70, 29.98; % masz 
    29.99, 30.72; % zająca
];

fprintf('\n\n\n----- RĘCZNE CZASY -----\n')
for k = 1:size(word_bounds_m, 1)
    start_w = round(word_bounds_m(k,1) * Fs);
    end_w   = round(word_bounds_m(k,2) * Fs);

    word_audio = a(start_w:end_w);
    fprintf('Słowo %d (czas: %.2f–%.2f s)\n', k, start_w/Fs, end_w/Fs);
    % sound(word_audio, Fs);
end


%-------------------------------------------------------------------EVENING

%% 
%[a2, Fs2] = audioread('evening.mp3');

%seg_m1 = a(segment_id==1);
%seg_e1 = a2(round(0.1*Fs2) : round(29.4*Fs2));

%fig = figure;
%subplot(2,1,1), plot(seg_m1); title('Rano');
%subplot(2,1,2), plot(seg_e1); title('Wieczór');
%saveas(fig, 'seg1_morning_vs_evening.png');

[b, Fs_e] = audioread('evening.mp3');

% Wyodrębnienie fragmentu 0–29 s
b = b(1:round(32.00 * Fs_e), :); % tylko do 32 sekundy

% Wysłuchanie (opcjonalnie)
%sound(b, Fs_e);

word_bounds_e = [
     1.30,  1.85; % jedzą
     1.90,  2.55; % piją 
     2.58,  3.03; % lulki
     3.05,  3.60; % palą 
     3.70,  4.40; % tańce
     4.40,  4.92; % hulanka
     4.95,  5.75; % swawola
     6.00,  6.50; % ledwie
     6.55,  6.97; % karczmy
     6.97,  7.20; % nie
     7.20,  7.90; % rozwalą
     8.20,  8.45; % ha
     8.45,  8.77; % ha
     8.78,  9.05; % hi
     9.05,  9.30; % hi
     9.60, 10.00; % hejze 
    10.00, 10.50; % hola

    11.00, 11.78; % Twardowski
    11.78, 12.20; % siadł  
    12.20, 12.30; % w
    12.30, 12.70; % końcu
    12.70, 13.30; % stoła
    13.60, 14.00; % podparł
    14.00, 14.20; % się
    14.20, 14.35; % w
    14.35, 14.65; % boki
    14.65, 14.87; % jak 
    14.87, 15.50; % basza
    15.70, 16.10; % hulaj
    16.13, 16.70; % dusza
    16.90, 17.35; % hulaj
    17.35, 17.95; % woła
    18.10, 18.68; % śmieszy
    18.70, 19.17; % tumani
    19.18, 20.00; % przestrasza

    20.70, 21.35; % Żołnierzowi
    21.35, 21.52; % co 
    21.52, 21.78; % grał 
    21.78, 22.30; % zucha
    22.80, 23.25; % Wszystkich 
    23.25, 23.70; % łaje 
    23.74, 23.89; % i 
    23.90, 24.70; % potrąca
    25.00, 25.55; % Świsnął 
    25.55, 26.10; % szablą 
    26.10, 26.45; % koło 
    26.49, 27.10; % ucha
    27.35, 27.50; % Już 
    27.50, 27.67; % z 
    27.68, 28.30; % żołnierza 
    28.32, 28.55; % masz 
    28.57, 29.45; % zająca
];

for k = 1:size(word_bounds_e, 1)
    start_w = round(word_bounds_e(k,1) * Fs_e);
    end_w   = round(word_bounds_e(k,2) * Fs_e);

    word_audio = b(start_w:end_w);
    fprintf('Słowo %d (czas: %.2f–%.2f s)\n', k, start_w/Fs_e, end_w/Fs_e);
    %sound(word_audio, Fs_e);

    % Pauza - długość słowa + 0.3s buforu, żeby zdążyło się odtworzyć
    %pause((end_w - start_w)/Fs_e + 0.3);
end

% Obliczenie czasów trwania słów
dur_morning = word_bounds_m(:,2) - word_bounds_m(:,1);
dur_evening = word_bounds_e(:,2) - word_bounds_e(:,1);

% Różnice
dur_diff = dur_evening - dur_morning;

% Klasyfikacja
slower_in_evening = dur_diff > 0;  % jeśli wieczorem dłużej
slower_in_morning = dur_diff < 0;  % jeśli rano dłużej

% Wyniki
num_slower_evening = sum(slower_in_evening);
num_slower_morning = sum(slower_in_morning);
min_diff = min(dur_diff);
max_diff = max(dur_diff);
mean_diff = mean(dur_diff);

% Wyświetlenie wyników
fprintf('\n--- ŚREDNI CZAS WYMOWY KAŻDEGO SŁOWA ---\n');
fprintf('Nr\tRano (s)\tWieczór (s)\tRóżnica (s)\n');
for i = 1:length(dur_morning)
    fprintf('%2d\t%.3f\t\t%.3f\t\t%.3f\n', i, dur_morning(i), dur_evening(i), dur_diff(i));
end

fprintf('\n--- PODSUMOWANIE ---\n');
fprintf('Słów wolniejszych wieczorem: %d\n', num_slower_evening);
fprintf('Słów wolniejszych rano:     %d\n', num_slower_morning);
fprintf('MIN różnica: %.3f s\n', min_diff);
fprintf('MAX różnica: %.3f s\n', max_diff);
fprintf('ŚREDNIA różnica: %.3f s\n', mean_diff);

num_words = size(word_bounds_m, 1);

dur_morning = word_bounds_m(:,2) - word_bounds_m(:,1);
dur_evening = word_bounds_e(:,2) - word_bounds_e(:,1);

figure;
bar(1:num_words, [dur_morning, dur_evening]);
xlabel('Numer słowa');
ylabel('Czas trwania (s)');
legend('Poranek', 'Wieczór');
title('Czas trwania słów - poranek vs wieczór');
grid on;



diff_dur = dur_evening - dur_morning;

figure;
histogram(diff_dur, 'BinWidth', 0.05);
xlabel('Różnica czasu trwania słów (wieczór - poranek) [s]');
ylabel('Liczba słów');
title('Histogram różnicy czasu trwania słów');
grid on;

% Statystyki
fprintf('Słów wolniej wypowiedzianych wieczorem: %d\n', sum(diff_dur > 0));
fprintf('Słów szybciej wypowiedzianych wieczorem: %d\n', sum(diff_dur < 0));
fprintf('Średnia różnica: %.3f s\n', mean(diff_dur));
fprintf('Min: %.3f s, Max: %.3f s\n', min(diff_dur), max(diff_dur));


% Wyliczenie długości przerw między słowami
pause_m = word_bounds_m(2:end,1) - word_bounds_m(1:end-1,2);
pause_e = word_bounds_e(2:end,1) - word_bounds_e(1:end-1,2);

% Średni czas przerwy
mean_pause_m = mean(pause_m);
mean_pause_e = mean(pause_e);

% Różnice przerw (wieczór - poranek)
pause_diff = pause_e - pause_m;

% Statystyki
fprintf('--- Przerwy między słowami ---\n');
fprintf('Średnia przerwa PORANEK: %.3f s\n', mean_pause_m);
fprintf('Średnia przerwa WIECZÓR:  %.3f s\n', mean_pause_e);
fprintf('Średnia różnica przerw: %.3f s\n', mean(pause_diff));
fprintf('Min różnica: %.3f s, Max: %.3f s\n', min(pause_diff), max(pause_diff));

%%
num_words_to_analyze = min(5, size(word_bounds_m, 1));
num_words_to_analyze_e = min(5, size(word_bounds_e, 1));

num_words_to_analyze = min(num_words_to_analyze, num_words_to_analyze_e);

% Częstotliwość próbkowania dla pitch
pitch_fs_m = Fs / hop;

% Ekstrakcja cech dla 'evening.mp3'
prop_e = audioFeatureExtractor('SampleRate', Fs_e, ...
    'SpectralDescriptorInput','barkSpectrum', ...
    'pitch', true, ...
    'spectralFlux', true, ...
    'harmonicRatio', true, ...
    'spectralSpread', true);
wyn_e = extract(prop_e, b);
pitch_e = wyn_e(:,3);
pitch_fs_e = Fs_e / hop;

% Jedna figura dla wszystkich wykresów
figure('Name', 'Porównanie Pitchu Porannego i Wieczornego dla Pierwszych Słów', 'Position', [100 100 1200 800]); % Pozycja i rozmiar figury

fprintf('\n--- Porównanie Pitchu Porannego i Wieczornego na Jednej Figurze (Oś X od 0) ---\n');

for k = 1:num_words_to_analyze
    subplot(3, 2, k);
    hold on;

    % Dane dla Morning 
    word_start_sec_m = word_bounds_m(k,1);
    word_end_sec_m = word_bounds_m(k,2);

    pitch_start_idx_m = round(word_start_sec_m * pitch_fs_m) + 1;
    pitch_end_idx_m = round(word_end_sec_m * pitch_fs_m) + 1;

    pitch_start_idx_m = max(1, pitch_start_idx_m);
    pitch_end_idx_m = min(length(pitch), pitch_end_idx_m);

    current_word_pitch_m = pitch(pitch_start_idx_m : pitch_end_idx_m);

    % Czas dla pitch z Morning, zaczynający się od 0
    duration_pitch_m = (length(current_word_pitch_m) - 1) / pitch_fs_m;
    t_word_pitch_m = linspace(0, duration_pitch_m, length(current_word_pitch_m));

    plot(t_word_pitch_m, current_word_pitch_m, 'b', 'DisplayName', 'Morning Pitch');

    % Dane dla Evening 
    word_start_sec_e = word_bounds_e(k,1);
    word_end_sec_e = word_bounds_e(k,2);

    pitch_start_idx_e = round(word_start_sec_e * pitch_fs_e) + 1;
    pitch_end_idx_e = round(word_end_sec_e * pitch_fs_e) + 1;

    pitch_start_idx_e = max(1, pitch_start_idx_e);
    pitch_end_idx_e = min(length(pitch_e), pitch_end_idx_e);

    current_word_pitch_e = pitch_e(pitch_start_idx_e : pitch_end_idx_e);

    % Czas dla pitch z Evening, zaczynający się od 0
    duration_pitch_e = (length(current_word_pitch_e) - 1) / pitch_fs_e;
    t_word_pitch_e = linspace(0, duration_pitch_e, length(current_word_pitch_e));

    plot(t_word_pitch_e, current_word_pitch_e, 'r--', 'DisplayName', 'Evening Pitch');

    xlabel('Względny Czas [s]');
    ylabel('Pitch [Hz]');
    title(sprintf('Słowo %d', k)); 
    legend show;
    grid on;
    hold off;

    % Wypisywanie statystyk w konsoli
    current_word_pitch_filtered_m = current_word_pitch_m(current_word_pitch_m > 0 & ~isnan(current_word_pitch_m));
    current_word_pitch_filtered_e = current_word_pitch_e(current_word_pitch_e > 0 & ~isnan(current_word_pitch_e));

    fprintf('\nSłowo %d:\n', k);
    fprintf('  Czas trwania Morning: %.2f s\n', word_end_sec_m - word_start_sec_m);
    fprintf('  Czas trwania Evening: %.2f s\n', word_end_sec_e - word_start_sec_e);

    fprintf('  --- Morning ---\n');
    if isempty(current_word_pitch_filtered_m)
        fprintf('    Brak znaczących danych pitch.\n');
    else
        fprintf('    Średni pitch: %.2f Hz\n', mean(current_word_pitch_filtered_m));
        fprintf('    Minimalny pitch: %.2f Hz\n', min(current_word_pitch_filtered_m));
        fprintf('    Maksymalny pitch: %.2f Hz\n', max(current_word_pitch_filtered_m));
        fprintf('    Zakres zmian pitch: %.2f Hz\n', max(current_word_pitch_filtered_m) - min(current_word_pitch_filtered_m));
    end

    fprintf('  --- Evening ---\n');
    if isempty(current_word_pitch_filtered_e)
        fprintf('    Brak znaczących danych pitch.\n');
    else
        fprintf('    Średni pitch: %.2f Hz\n', mean(current_word_pitch_filtered_e));
        fprintf('    Minimalny pitch: %.2f Hz\n', min(current_word_pitch_filtered_e));
        fprintf('    Maksymalny pitch: %.2f Hz\n', max(current_word_pitch_filtered_e));
        fprintf('    Zakres zmian pitch: %.2f Hz\n', max(current_word_pitch_filtered_e) - min(current_word_pitch_filtered_e));
    end
end

sgtitle('Porównanie Pitchu dla Pierwszych 5 Słów (Morning vs. Evening)');