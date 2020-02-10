function   code(folder, n, CodeBook)
% Speaker Recognition: Testing Stage
% folder : string name of directory contains all test sound files
% n       : number of test files in testdir
% CodeBook    : codebooks of all trained speaker

%% CODE

%===================================================================
% reading the audio files.

K= 8;                       
files = dir(fullfile(folder,'*.wav'));
audio = cell(1,4);
for i = 1:n
     [y,Fs] = audioread(files(i).name);
 
     sound (y,Fs)
%====================================================================

% Compute MFCC

    v = MFCCProcessor(y, Fs,i+2);            
   
    MinDistance = inf;
    x = i;
% =================================================================

% compute Euclidean Distance and distortion

    for l = 1:length (CodeBook)      
        d = EDistance(v, CodeBook{l}); 
        Distance = sum(min(d,[],2)) / size(d,1);
      
        if Distance < MinDistance
            MinDistance = Distance;
            x = i;
        end      
    end
   
    msg = sprintf('Speaker %d matches with speaker %d', i, x);
    disp(msg);
end