threshold = 1;
noiseSNRdb = 20;
sampleSize = [1 1e3];
Kdb = -10:20;
%   get the ratio in number, and not dB
K = 10.^(Kdb./10);

ge = mean(randi([0 100], sampleSize));
gd = K.*ge;

lambda = 10^threshold;

sop = 1-exp((-lambda+1)./gd).*(gd./(lambda*ge+gd));
figure;
semilogy(Kdb, sop);
grid on;
hold on;

noiseSNRdb = 20;
Kdb = -10:20;
%   get the ratio in number, and not dB
K = 10.^(Kdb./10);



lambda = 10^threshold;

sop = 1-exp((-lambda+1)./gd).*(gd./(lambda*ge+gd));
figure;
semilogy(Kdb, sop);