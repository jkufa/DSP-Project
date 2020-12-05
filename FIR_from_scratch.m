%Headers
clear all % this clears all your variables
load handel;

%Definition of audio file
[x,Fs]=audioread('tyler.ogg'); % reads in the file
m = length(x);            % calculates the length of the signal
m1 = pow2(nextpow2(m));   % chooses the next higher power of 2

%Sound pressure spectrum of original audio
figure(1);
subplot(2,1,1)
plot((1:m)/Fs,x);
%formatting
xlabel('Time [s]');
ylabel('Sound pressure');
title('Original - Music time series');
xlim([0 4])
ylim([-1 1])

%Play original audio
p8 = audioplayer(x,Fs); %define audio object
playblocking(p8); %play audio object

%FFT and power spectrum of original audio
X = fft(x,m1);            % takes the fft of signal
f = (0:m1-1)*(Fs/m1);     % sets your frequency variable range
power = abs(X).^2/m1;     % calculates the power of the signal
figure(2);                 % creates a new plot window
plot(f(1:floor(m1/2)), power(1:floor(m1/2)));     % plots the power
xlabel('Frequency (Hz)');           % labels the horizontal axis
ylabel('Power');                    % labels the vertical axis
title('Original Power Spectrum for tyler.ogg');  % graph title
xlim([0 3000])
ylim([0 60])

%High pass Hann Filter definition
Fc = 4600; %frequency cut-off
fc = Fc/Fs; %normalized cut-off frequency
M = 300; %filter order
n = 0:1:M;
w = 0.5.*(1-cos(2*n*pi/M)); %hann filter algorithm
%high pass filter
hs = 2*(0.5)*sinc(2*(0.5)*(n-M/2))-2*fc*sinc(2*fc*(n-(M/2)));
hw = hs.*w; %windowed impulse response
HW = fft(hw,m1); %fft of signal
HWdB = 20*log10(abs(HW)); %convert to dB
HWdB2 = HWdB(1:(m1/2)); %shorten dB to plot
n1 = 0:1:(m1/2)-1; %new plot index
figure(3);
plot((n1/m1),HWdB2);
%formatting
title('Filter Magnitude in dB');
xlabel('Noramlized frequency');
ylabel('dB');

%Apply Hann Filter to original audio
Y = X.*(HW.');
power2 = abs(Y).^2/m1; %convert to power
figure(4);
plot(f(1:floor(m1/2)), power2(1:floor(m1/2)));
%formatting
title('HP Filtered Power Spectrum for tyler.ogg');
xlabel('Frequency (Hz)');
ylabel('Power');
xlim([0 3000])
ylim([0 60])

%Inverse FFT to retrieve filtered audio
fil = ifft(Y); %inverse fft
mfil = length(fil); %calculates the length of the signal

%Play filtered audio
xtrafil = fil*3.6; % Increase volume
player = audioplayer(xtrafil, Fs);
play(player,[1 (get(player, 'SampleRate')*3)]);
%audiowrite('tyler_hihat.ogg',xtrafil,Fs)

%Sound pressure spectrum of filtered audio
figure(5);
subplot(2,1,1)
%formatting
plot((1:mfil)/Fs,xtrafil);
xlabel('Time [s]');
ylabel('Sound pressure');
title('High Pass - Music time series');
xlim([0 4])
ylim([-1 1])

%Low pass Hann Filter definition
Fc = 50; %frequency cut-off
fc = Fc/Fs; %normalized cut-off frequency
M = 300; %filter order
n = 0:1:M;
w = 0.5.*(1-cos(2*n*pi/M)); %hann filter algorithm
%low pass filter
hs = 2*fc*sinc(2*fc*(n-(M/2)));
hw = hs.*w; %windowed impulse response
HW = fft(hw,m1); %fft of signal
HWdB = 20*log10(abs(HW)); %convert to dB
HWdB2 = HWdB(1:(m1/2)); %shorten dB to plot
n1 = 0:1:(m1/2)-1; %new plot index
figure(6);
plot((n1/m1),HWdB2);
%formatting
title('Filter Magnitude in dB');
xlabel('Noramlized frequency');
ylabel('dB');

%Apply Hann Filter to original audio
Y = X.*(HW.');
power2 = abs(Y).^2/m1; %convert to power
figure(7);
plot(f(1:floor(m1/2)), power2(1:floor(m1/2)));
%formatting
title('LP Filtered Power Spectrum for tyler.ogg');
xlabel('Frequency (Hz)');
ylabel('Power');
xlim([0 3000])
ylim([0 60])

%Inverse FFT to retrieve filtered audio
fil = ifft(Y); %inverse fft
mfil = length(fil); %calculates the length of the signal

%Play filtered audio
xtrafil = fil*3.6; % Increase volume
player = audioplayer(xtrafil, Fs);
play(player,[1 (get(player, 'SampleRate')*3)]);
%audiowrite('tyler_basevocal.ogg',xtrafil,Fs)

%Sound pressure spectrum of filtered audio
figure(8);
subplot(2,1,1)
%formatting
plot((1:mfil)/Fs,xtrafil);
xlabel('Time [s]');
ylabel('Sound pressure');
title('Low Pass - Music time series');
xlim([0 4])
ylim([-1 1])
