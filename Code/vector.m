function CodeBook = vector(MFCC, K)
%  Vector quantization using the Linde-Buzo-Gray algorithm
%  d : contains training data vectors (one per column)
%  K : number of centroids required
%  CodeBook :  contains the result Vector Quantisation (Vector.m) codebook (k columns, one for each centroids)
%  C  : number of code words per centroid
%  z : distortion 
%  D : distance between point and each n every code word 
%  Point : it tells the points in 'MFCC' to the nearest centroid
%% CODE

s = 0.02;                                 % splitting parameter
CodeBook = mean(MFCC, 2);                        
z = int32(inf);             
C = int32(log2(K));    

%===================================================================

% Splitting the CodeBook 

for i=1:C
    CodeBook = [CodeBook*(1+s), CodeBook*(1-s)]; 
%=================================================================

% Nearsest Neighbor Search 

        D = EDistance(MFCC, CodeBook);            
        [m,Point] = min(D, [], 2);         
%=================================================================

% Updating the centroid with with new codeword vector

        t = 0;
        lim = 2^i;
        for j=1:lim
            CodeBook(:, j) = mean(MFCC(:, Point==j), 2);    
            x = EDistance(MFCC(:, Point==j), CodeBook(:, j));  
            len = length(x);                        
            for q = 1:len
                t = t + x(q);
            end
        end
%===================================================================

% distortion Condition. 
        
        if (((z - t)/t) < s)      
            break;
        else
            z = t;
        end
    end
end
%=====================================================================