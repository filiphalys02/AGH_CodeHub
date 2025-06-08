%% 1
clear; clc; close all;

%% 2
videoFile = '100_LAT_AGH.mp4';
video = VideoReader(videoFile);

frameCount = floor(video.Duration * video.FrameRate);
fprintf('Czas trwania: %.2f sek, Liczba klatek: %d\n', video.Duration, frameCount);

frames = {};
i = 1;

while hasFrame(video)
    frame = readFrame(video);
    frameGray = rgb2gray(frame); 
    frames{i} = frameGray;
    i = i + 1;
end

numFrames = length(frames);

%% 3. Oblicz różnice między sąsiednimi klatkami
diffs = zeros(1, numFrames - 1);

for i = 1:numFrames-1
    diff = abs(double(frames{i}) - double(frames{i+1}));
    diffs(i) = mean(diff(:));
end

%% 4. Wykrycie cięć – próg empiryczny
rawCuts = [];

for i = 1:numFrames - 1
    if i <= 600
        threshold = 15;
    elseif i <= 1500
        threshold = 43;
    else
        threshold = 15;
    end

    if diffs(i) > threshold
        rawCuts = [rawCuts, i];
    end
end

minDistance = 10;

[~, sortIdx] = sort(diffs(rawCuts), 'descend');
sortedCuts = rawCuts(sortIdx);

finalCuts = [];

for i = 1:length(sortedCuts)
    currentCut = sortedCuts(i);
    
    if all(abs(finalCuts - currentCut) >= minDistance)
        finalCuts = [finalCuts, currentCut];
    end
end

cuts = sort(finalCuts);

fprintf('Wykryto %d potencjalnych cięć sceny (po filtrowaniu).\n', length(cuts));

%% 5
figure;
plot(diffs, 'b');
hold on;

xline(600, 'k--', 'Frame 600');
xline(1500, 'k--', 'Frame 1500');

yline(15, 'g--', 'Próg 15', 'LabelVerticalAlignment','bottom');
yline(43, 'm--', 'Próg 43', 'LabelVerticalAlignment','bottom');

scatter(cuts, diffs(cuts), 60, 'ro', 'filled');

title('Różnice między klatkami z trzema progami i cięciami');
xlabel('Numer klatki');
ylabel('Średnia różnica pikseli');

legend('Różnice', 'Frame 600', 'Frame 1500', 'Próg 15', 'Próg 43', 'Cięcia');

%% 6 
for i = 1:length(cuts)
    figure;
    imshow(frames{cuts(i)});
    title(sprintf('Potencjalne cięcie: klatka %d', cuts(i)));
    pause(0.5);
end

%%
outputFolder = 'ciecia'; 
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

for i = 1:length(cuts)
    frameIdx = cuts(i);
    img = frames{frameIdx};
    filename = fullfile(outputFolder, sprintf('ciecie_%03d.png', frameIdx));
    imwrite(img, filename);
end

fprintf('Zapisano %d klatek z cięciami do folderu "%s"\n', length(cuts), outputFolder);
