%% Read in the file
clearvars;
close all;
[x,fs] = audioread('tyler.ogg');

%% Play original file
% pOrig = audioplayer(x,fs);
% pOrig.play;

%% Plot both audio channels
N = size(x,1); % Determine total number of samples in audio file
figure;
subplot(2,1,1);
stem(1:N, x(:,1));
title('Left Channel');
subplot(2,1,2);
stem(1:N, x(:,2));
title('Right Channel');

%% Plot the spectrum
df = fs / N;
w = (-(N/2):(N/2)-1)*df;
y = fft(x(:,1), N) / N; % For normalizing, but not needed for our analysis
y2 = fftshift(y);
figure;
plot(w,abs(y2));

%% Design a bandpass filter that filters out between 700 to 12000 Hz
n = 7;
beginFreq = 4500 / (fs/2);
endFreq = 6500 / (fs/2);
[b,a] = butter(n, [beginFreq, endFreq], 'bandpass');

%% Filter the signal
fOut = filter(b, a, x);

%% Construct audioplayer object and play
p = audioplayer(fOut, fs);
p.play;
