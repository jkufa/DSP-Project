%Michael Dickerson
%EE3410 Signal Analysis

%1a
clear all               % this clears all your variables
[x,Fs]=audioread('tyler_original.ogg'); % reads in the file
m=length(x);            % calculates the length of the signal
m1=pow2(nextpow2(m));   % chooses the next higher power of 2
X=fft(x,m1);            % takes the fft of signal
f=(0:m1-1)*(Fs/m1);     % sets your frequency variable range
figure(1); % open window for fft
stem((f./Fs),abs(X),'Marker', 'none'); % plot fft
xlabel('Frequency');
ylabel('Magnitude');
title('FFT of tyler_orginal.ogg');
power=abs(X).^2/m1;     % calculates the power of the signal figure
figure(2);% creates a new plot window
plot(f(1:floor(m1/2)),power(1:floor(m1/2)))     % plots the power
xlabel('Frequency (Hz)');
ylabel('Power');
title('Power Spectrum Components for tyler_orginal.ogg');
