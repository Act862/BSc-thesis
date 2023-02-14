thresholdCapacity = 1;
lambda = 2^thresholdCapacity;

snrmax = 60;
snrmin = -60;
random_snrs = rand(1000, 1) * (snrmax - snrmin) + snrmin;

Kdb = -10:50;
K = 10.^(Kdb./10);

avgSNR_eve = mean(random_snrs);
avgSNR_dest = K.*avgSNR_eve;

f1 = exp((-lambda+1)./avgSNR_dest);
f2 = avgSNR_dest./(lambda*avgSNR_eve+avgSNR_dest);

sop = 1 - f1.*f2;

semilogy(Kdb, sop);
ylabel('Secrecy Outage Probability');
xlabel('Destination to Eavesdropper ration K (dB)');

%% for a grater threshold capacity
thresholdCapacity = 2:5;
lambda = 2.^thresholdCapacity;

for i=lambda
    f1 = exp((-i+1)./avgSNR_dest);
    f2 = avgSNR_dest./(i*avgSNR_eve+avgSNR_dest);
    sop = 1 - f1.*f2;
    hold on;
    semilogy(Kdb, sop);
    hold off;
end
grid on;