function d = EDistance(x, y)
% DISTEU Pairwise Euclidean distances between columns of two matrices
% x : MFCC matrix 
% y : CodeBook Matrix  
% d : Euclidean Distance between x and y first column  

%==========================================================================

%% CODE 

[R1, C1] = size(x);
[R2, C2] = size(y); 

if (R1 ~= R2)
    error('Matrix dimensions do not match.')
end

d = zeros(C1, C2);

if (C1 < C2)
    copies = zeros(1,C2);
    for n = 1:C1
        d(n,:) = sum((x(:, n+copies) - y) .^2, 1);
    end
else
    copies = zeros(1,C1);
    for p = 1:C2
        d(:,p) = sum((x - y(:, p+copies)) .^2, 1)';
    end
end

d = d.^0.5;
end