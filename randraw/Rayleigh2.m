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

avgSNR_eve = 20;
avgSNR_dest = avgSNR_eve:100;

f12 = exp((-lambda+1)./avgSNR_dest);
f22 = avgSNR_dest./(lambda.*avgSNR_eve+avgSNR_dest);

SOP2 = 1 - f12.*f22;

hold on;
semilogy(avgSNR_dest, SOP2);
hold off;
grid on;