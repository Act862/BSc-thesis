thresholdCapacity = 1;
lambda = 2^thresholdCapacity;

avgSNR_dest = 5;
avgSNR_eve = 0:0.1:30;

f1 = exp((-lambda+1)./avgSNR_dest);
f2 = avgSNR_dest./(lambda.*avgSNR_eve+avgSNR_dest);

SOP = 1 - f1.*f2;

semilogy(avgSNR_eve, SOP);
xlabel('Eavesdropper average SNR');
ylabel('Secrecy Outage Probability');

avgSNR_dest = 10;
f12 = exp((-lambda+1)./avgSNR_dest);
f22 = avgSNR_dest./(lambda.*avgSNR_eve+avgSNR_dest);
SOP2 = 1 - f12*f22;

hold on;
semilogy(avgSNR_eve, SOP2);
hold off;
legend('destination average SNR = 5', 'destination average SNR = 5', 'Location', 'Southeast');
grid on;