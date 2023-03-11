thresholdCapacity = 1;
lambda = 2^thresholdCapacity;
snr_dB = -10:2:30; % range of SNR values in dB
avgSNR_dest = 10.^(snr_dB/10);
avgSNR_eve = 1;

f1 = exp((-lambda+1)./avgSNR_dest);
f2 = avgSNR_dest./(lambda.*avgSNR_eve+avgSNR_dest);

SOP = 1 - f1.*f2;

semilogy(snr_dB, SOP);
xlabel('Destination average SNR');
ylabel('Secrecy Outage Probability');

avgSNR_eve = 2;

f12 = exp((-lambda+1)./avgSNR_dest);
f22 = avgSNR_dest./(lambda.*avgSNR_eve+avgSNR_dest);

SOP2 = 1 - f12.*f22;

hold on;
semilogy(snr_dB, SOP2);
hold off;
legend('eavesdropper average SNR = 1', 'eavesdropper average SNR = 2', 'Location', 'Southwest');
grid on;