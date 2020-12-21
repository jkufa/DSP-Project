%% Read in the file
clearvars;
close all;
[x,fs] = audioread('tyler_original.ogg');

%% Plot both audio channels
N = size(x,1); % Determine total number of samples in audio file

%% Plot power spectrum
df = fs / N;
w = (-(N/2):(N/2)-1)*df;
y = fft(x(:,1), N) / N; % Normalize freq
y2 = fftshift(y);
figure;
plot(w,abs(y2));
title('Power Spectrum');
subtitle('tyler_orginal.ogg');
ylabel('Power');
xlabel('Normalized frequency');

%% Create 11th order lowpass filter
n = 11;
initial_freq = 500 / (fs/2);
[b,a] = butter(n, initial_freq, 'low');
h = fvtool(b,a);

%% Filter the signal
f_out = filter(b, a, x);

%% Construct audioplayer object and play
p = audioplayer(f_out, fs);
p.play;

%% write to file
audiowrite('tyler_butterworth_lowpass.wav',f_out,fs)