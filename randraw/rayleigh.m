threshold = 1;
noiseSNRdb = 20;
sampleSize = [1 1e3];
Kdb = -10:20;
%   get the ratio in number, and not dB
K = 10.^(Kdb./10);

snrmax = 60;
snrmin = -60;
random_snrs = rand(1000, 1) * (snrmax - snrmin) + snrmin;
ge = mean(random_snrs);
gd = K.*ge;

lambda = 10^threshold;

sop = 1-exp((-lambda+1)./gd).*(gd./(lambda*ge+gd));
figure;
semilogy(ge, sop);
grid on;