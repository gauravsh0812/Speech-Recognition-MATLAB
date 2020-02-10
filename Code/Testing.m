%% CODE

function Speaker = Testing (folder)

K=20;
n=3;
files = dir(fullfile(folder,'*.wav'));       % taking the files from the folder
audio = cell(1,4);
 for i = 1:n
     [y,Fs] = audioread(files(i).name);      % reading the .wav files
 
     sound (y,Fs)                            % playing those audio files
    
d = MFCCProcessor(y,Fs,i+2);

%========================================================
%  PLOTTING THE .wav FILE
    y = y(:,1);
    dt = 1/Fs;
    t = 0:dt:(length(y)*dt)-dt;
    figure(1)
    plot(t,y);
    title('Time varying Speech Signal');
    grid on;xlabel('Seconds'); ylabel('Amplitude');
    
%==========================================================
% POWER SPECTRAL DENSITY 
    figure (2)
    plot(psd(spectrum.periodogram,y,'Fs',Fs,'NFFT',length(y)));

%============================================================
% Call vector.m to get codebk as output
Codebook{i} = vector(d, K);
 end
%============================================================
% Use the codebk as input for the call of test.m
code(folder, n, Codebook);
%============================================================


