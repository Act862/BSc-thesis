% Nakagami channel generator
function [Na] = Nakagamim(Nt,Nr,mu,Omega);
% Uniformly distributed phase;
alpha = 2*pi*rand(Nt,Nr);

% Nakagami distributed magnitude
H = randraw('nakagami', [mu,Omega], [Nt,Nr]);


Na = H.*exp(alpha*sqrt(-1));