function phase1out = Training(folder)
%% PHASE1 => TRAINING PHASE
% Speaker Recognition Phase 1 : train the system
% folder   : string name/path of directory contains all train sound files
%            of (.wav) format  (folder name = soundlist )
% n        : number of sound files in the directory mentioned above
% code     : trained Vector Questiont codebooks (code{i} for i-th speaker)
%            (FUNCTION named vector)
% K       : No. of centroids
%% CODE:

%===================================================================
% reading the audio files.

K= 20;    
n=3;
files = dir(fullfile(folder,'*.wav'));
audio = cell(1,4);
 for i = 1:n
     [y,Fs] = audioread(files(i).name);
 
     sound (y,Fs) 
     MFCC = MFCCProcessor(y,Fs);
   phase1out{i} = vector(MFCC, K);  
 
 
 %================================================================
 
 %  PLOTTING THE .wav FILE
    y = y(:,1);
    dt = 1/Fs;
    t = 0:dt:(length(y)*dt)-dt;
    figure(1)
    plot(t,y); xlabel('Seconds'); ylabel('Amplitude');
    grid on;
    title('Time Varying Speech Signal');
 xlabel('Seconds'); ylabel('Amplitude');
 %=================================================================
 
 % POWER SPECTRAL DENSITY 
    figure (2)
    plot(psd(spectrum.periodogram,y,'Fs',Fs,'NFFT',length(y)));
    title('Power Spectral Density of Speech Wave');
 %=================================================================
 end    
 end
%===================================================================