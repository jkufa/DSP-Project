% part a)
[x,Fs]=audioread('classical.wav');
m =  length(x);
m1 = pow2(nextpow2(m));
X = fft(x,m1);
f = (0:m1-1)*(Fs/m1);
power = abs(X).^2/m1;

figure
plot(f(1:floor(m1/2)),power(1:floor(m1/2)));
title('Power Spectrum Components');
subtitle('classical.wav');
xlabel('Frequency (Hz)');
ylabel('Power');
xlim([0 4000])
ylim([0 16])
saveas(gcf,'a.png')

% part b)
M = 60;
Fc = 600;
fc = Fc/Fs;
n = 0:1:M;
hw = 0.54-.46.*cos(2*n*pi/M); % Hamming window
hs = 2*fc*sinc(2*fc*(n-(M/2)));
hw = hs.*hw;
HW = fft(hw,m1);
HW_dB = 20*log10(abs(HW));
HW_dB = HW_dB(1:m1/2);
n1 = 0:1:m1/2-1;

figure
plot(n1/m1, HW_dB);
title('Hamming Filter Magnitude (dB)');
subtitle('classical.wav');
xlabel('Normalized frequency');
ylabel('dB');
saveas(gcf,'b.png')

% part c)
Y=X.*(HW.');
power = abs(Y).^2/m1;

figure
plot(f(1:floor(m1/2)),power(1:floor(m1/2)));
title('Power Spectrum Components: Lowpass Filter');
subtitle('classical.wav');
xlabel('Frequency (Hz)');
ylabel('Power');
xlim([0 4000])
saveas(gcf,'c.png')

% part d)
w = 1-((n-(M/2))./(M-2)).^2;
hs = 2*.5*sinc(2*.5*(n-M/2))-2*fc*sinc(2*fc*(n-(M/2)));
hw=hs.*w;
HW = fft(hw, m1);
HW_dB = 20*log10(abs(HW));
HW_dB = HW_dB(1:m1/2);
n1 = 0:1:m1/2-1;

figure
plot(n1/m1, HW_dB);
title('Welch Filter Magnitude (dB)');
subtitle('classical.wav');
xlabel('Normalized frequency');
ylabel('dB');
saveas(gcf,'d.png')

% part e)
Y=X.*(HW.');
power = abs(Y).^2/m1;

figure
plot(f(1:floor(m1/2)),power(1:floor(m1/2)));
title('Power Spectrum Components: Highpass Filter');
subtitle('classical.wav');
xlabel('Frequency (Hz)');
ylabel('Power');
xlim([0 4000])
saveas(gcf,'e.png')