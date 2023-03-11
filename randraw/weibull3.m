Kdb = 0:30;
K = 10.^(Kdb./10);

avgSNR_eve = 0.15;
avgSNR_dest = K.*avgSNR_eve;

c = 2;
Cth = 1;
t = 2^Cth;

q = gamma(1+2/c)/avgSNR_eve;
p = gamma(1+2/c)./avgSNR_dest;
j = (c/2)*(gamma(1+c/2)/avgSNR_eve);

% this is the first integral
i1 = 2*q^(-c/2)/c;

%   the second integral changes based on the shape parameter
i2 = exp(p-p.*t)./(q+p.*t);

SOP2 = ((c*j)/2).*(i1-i2);

semilogy(Kdb, SOP2);
ylabel('Secrecy Outage Probability');
xlabel('Destination to Eavesdropper ratio K (dB)');

c = 4;

q = gamma(1+2/c)/avgSNR_eve;
p = gamma(1+2/c)./avgSNR_dest;
j = (c/2)*(gamma(1+c/2)/avgSNR_eve);

%   the first integral
i1 = 2*q^(-c/2)/c;

%   the second integral for c = 4 is going to be broken in parts
% Define constants
e = exp(1);
pi_sqrt = sqrt(pi);
% Calculate intermediate values (using element-wise operations)
term1 = e.^(-p.^2.*(t-1).^2);
term2 = sqrt(p.^2.*t.^2+q^2) - pi_sqrt*p.^2.*(t-1).*t.*e.^((p.^4.*(t-1).^2.*t.^2)./(p.^2.*t.^2+q^2)).*erfc((p.^2.*(t-1).*t)./sqrt(p.^2.*t.^2+q^2));
term3 = 2.*(p.^2.*t.^2+q^2).^(3/2);

% Calculate final result (using element-wise operations)
i4 = term1.*term2./term3;

SOP4 = ((c*j)/2).*(i1-i4);

hold on;
semilogy(Kdb, SOP4);
hold off;


legend('c=2', 'c=4', 'Location','Southwest');
grid on;