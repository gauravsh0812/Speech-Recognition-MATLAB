function MFW = MelFreqWrap(Frames, N, Fs,n)
% MELFB : Determine matrix for a mel-spaced filterbank
% MFW : Matrix of amplitude of filter bank.

%% CODE
f0 = 700 / Fs;
fn2 = floor(N/2);

lr = log(1 + 0.5/f0) / (Frames+1);

%==========================================================================

% convert to fft bin numbers with 0 for DC term

bl = N * (f0 * (exp([0 1 Frames Frames+1] * lr) - 1));

b1 = floor(bl(1)) + 1;
b2 = ceil(bl(2));
b3 = floor(bl(3));
b4 = min(fn2, ceil(bl(4))) - 1;

pf = log(1 + (b1:b4)/N/f0) / lr;
fp = floor(pf);
pm = pf - fp;

r = [fp(b2:b4) 1+fp(1:b3)];
c = [b2:b4 1:b3] + 1;
v = 2 * [1-pm(b2:b4) pm(1:b3)];

S = sparse(r, c, v, Frames, 1+fn2);
MFW=full(S);
end
