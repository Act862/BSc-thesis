%% this is the Rayleigh Fading SOP simulation
% plotting the sop with a variating K term
Cth = 1;
ebno = 10:-3:1;
ck = 1;
Kdb = -10:20;
K = 10.^(Kdb./10);
sopv = [];
% Call as sop = secrecyOutageProbCalc(Cth, ebno, ck, K)
% Cth is a scalar
% ebno is a vector
% ck is a scalar
% K is a vector
ge = ck.*ebno;
gd = ge.*K;
l = 2^Cth;
% SOP
for i=1:length(ebno)
    sop = 1-exp((-l+1)./gd).*(gd./(l*ge+gd));
    sopv = [sopv; sop]
end

figure();
hold on;
for i=1:length(ebno)
%     semilogy(Kdb, sopv(i,:), 'DisplayName',strcat('Eb/No= ',int2str(ebno(i))));
    semilogy(Kdb, sopv(i,:));
end
grid on;
% legend('Eb/No= 5','Eb/No= 4','Eb/No= 3','Eb/No= 2','Eb/No= 1');
legend;
title('Rayleigh Fading Channel SOP');
xlabel('K (dB)');
ylabel('SOP');
