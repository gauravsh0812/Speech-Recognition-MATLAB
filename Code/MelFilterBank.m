%% CODE

function [F] = MelFilterBank(Fs)

F1=0;
n=22;
Fm1=2595*log10(1+F1/700);
Fm2=2595*log10(1+Fs/700);
Fmw=(Fm2-Fm1)/(n+1);
Fm=Fm1:Fmw:Fm2;
F=700*(exp(Fm/1125)-1);

%====================================================================
% for plotting
x1=ones(1,n+2);
x1(1:2:(n+2))=0;
x2= zeros(1,n+2);
x2(1:2:(n+2))=1;
figure(5)
plot(F(1:21),x1(1:21))
hold on
plot(F(2:22),x2(2:22))
hold off
title('Mel Spaced Filter Bank'); xlabel('Frequency (Hz)');
end
