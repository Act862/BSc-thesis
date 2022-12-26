%%  generate a random sequence of 1000 numbers and send it over a rayleigh channel
data = randi([0 1], [1 1e5]);
%   this is the modulated symbols, x
% qpskModulator = comm.QPSKModulator;
bpskModulator = comm.BPSKModulator;
bpskModulator.PhaseOffset = pi/16;

%   this is the channel coefficients: h
scaleParam = 1;
size = [1 1e5];
channelCoefEavesdropper = randraw('rayl', scaleParam, size);
channelCoefDestination = randraw('rayl', scaleParam, size);
% for the noise we will add augmented white gaussian noise 
x = bpskModulator(data');

% a second attemp
rayleighchan = comm.RayleighChannel;
% y = h*x + n
%   the SNR is 20db
SNR = 20;

yd = awgn(channelCoefDestination.*x',SNR);
ye = awgn(channelCoefEavesdropper.*x',SNR);

ytest = awgn(rayleighchan(x), SNR);

% scatterplot(x);
% scatterplot(yd');
% scatterplot(ye');
% scatterplot(ytest');

%% now check the secrecy outage probability
Cth = 1;
% 1. find the average snr of each symbol
% 2. calculate the probability of this snr being below cth
N = 10^(SNR/10);
t = randi([0 length(ye')], [1 100]);
% the average SNR is the P of the signal to the Noise
P = [];
for i=t
    SNRe = abs(ye(i))/N;
    SNRd = abs(yd(i))/N;
    %   check the ratio
%     SNRe_db = 10*log10(SNRe);
%     SNRd_db = 10*log10(SNRd);
%     avgSNR = 10*log10(abs(x(i)^2)*SNRd);
%     K = SNRd_db/SNRe_db;
%     p = 1- exp(-K/avgSNR);
%     P = [P p];
end
% plot(P, 'o');


