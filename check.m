Cth = 1;
EbNo = 1;
ck = 1;
Kdb = -10:20;
K = 10.^(Kdb./10);
sopv = [];
% Call as sop = secrecyOutageProbCalc(Cth, ebno, ck, K)
% Cth is a scalar
% ebno is a vector
% ck is a scalar
% K is a vector
ge = ck.*EbNo;
gd = ge.*K;
l = 2^Cth;

sop = 1-exp((-l+1)./gd).*(gd./(l*ge+gd));
figure;
semilogy(Kdb, sop);
grid on;
