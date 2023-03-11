%% theoretical expression plot
thresholdCapacity = 1;
lambda = 2^thresholdCapacity;

avgSNR_eve = 10;
avgSNR_dest = avgSNR_eve:100;

f1 = exp((-lambda+1)./avgSNR_dest);
f2 = avgSNR_dest./(lambda.*avgSNR_eve+avgSNR_dest);

SOP = 1 - f1.*f2;

semilogy(avgSNR_dest, SOP);
xlabel('Destination average SNR');
ylabel('Secrecy Outage Probability');

%% simulation plot
sampleSize = 1e4;
% get the Rayleigh channel gains based on avgSNR_dest
h_dest = (randn(1,sampleSize) + 1i*randn(1,sampleSize))/sqrt(2);

channelGain_dest = abs(h).^2;
SOP2 = zeros(sampleSize,length(avgSNR_dest));





hold on;
semilogy(avgSNR_dest, SOP2);
hold off;
grid on;