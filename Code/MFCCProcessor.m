function MFCC = MFCCProcessor(y, Fs, m)
%% PARAMETERS USED:
% MFCC Calculate the mel frequencey cepstrum coefficients (MFCC) of a signal 
% y  : speech signal data
% Fs : sample rate in Hz of the speech signal data y
% c  : MFCC output, each column contains the MFCC's for one speech frame
% N  : no. of samples in a Frame
% M  : seperation between two Frames
% W  : window => overe here we are using HAMMING window.
% Wresult: the Square Diagonal Matrix we will get after doing windowing.
% FreqFFTMatrix : FFT in the frequency Domain
% ms : Mel- spectrum
% MFCC : Mel Frequency Cepstrum Cofficients

%% CODE:

N = 256;                                        % Frame size
M =  100;                                       % space between two frames
Frames = 1 + floor((length(y) - N)/double(M));  % calculation of the no. of frames

V = zeros(N, Frames); 


for n=1:Frames
    k = 100*(n-1) + 1;
    for j=1:N
        V(j,n) = y(k);                          % creating matrix conataing the sampled data y
        k = k + 1;
    end
end
%=====================================================================
% Windowing and FFT

W = hamming(N); 
figure(3)
plot(W); 
grid on; title ('Hamming Window Output'); xlabel('samples'); ylabel('amplitude');
WresultMatrix = diag(W)*V;  
FreqFFTMatrix = fft(WresultMatrix); 

%MelFreqWrap( Frames,N,Fs,n+2);

%======================================================

%   POWER SPECTRAL DENSITY & PERIODOGRAM OF FFT PLOTTING

rng default
f = 1000;
t = 0:1/f:1-1/f;
funct = cos(2*pi*100*t) + randn(size(t));
len = length(funct);
FreqFFTMatrix = fft(funct);
FreqFFTMatrix = FreqFFTMatrix(1:len/2+1);
PSD = (1/(f*len)) * abs(FreqFFTMatrix).^2;
PSD(2:end-1) = 2*PSD(2:end-1);
freq = 0:f/length(funct):f/2;
figure(4);
plot(freq,10*log10(PSD))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')

%======================================================

 % MEL-FREQUENCY WRAPPING 

[MelFrequencyVector] = MelFilterBank(Fs);    
    
y2 = 1 + floor(N/2);z=abs(FreqFFTMatrix(1:y2)).^2;z1= transpose(MelFrequencyVector);
ms = z1*z;

%======================================================

% FORMATION OF CEPSTRUM 

MFCC = dct(log(ms));                              
MFCC(:,1) = [] ;                     % we need to exclude the 0 order cepstrum             
end
 

