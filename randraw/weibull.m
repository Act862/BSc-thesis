%%  the global simulation parameters
% eavesdropper_avgSNR = 0.1
% destination_avgSNR = eavesdropper_avgSNR:30;
snr_dB = -10:1:30; % range of SNR values in dB
destination_avgSNR = 10.^(snr_dB/10);
eavesdropper_avgSNR = 0.1;

%% this is the weibull fading channel simulation for c = 2 (Rayleigh)

%   this simulation is going to mimic the Rayleigh theoretical simulation
%   We first have to define our parameters

%   this is the shape parameter c
c = 2;
Cth = 1;
t = 2^Cth;

q = gamma(1+2/c)/eavesdropper_avgSNR;
p = gamma(1+2/c)./destination_avgSNR;
j = (c/2)*(gamma(1+c/2)/eavesdropper_avgSNR);

% this is the first integral
i1 = 2*q^(-c/2)/c;

%   the second integral changes based on the shape parameter
i2 = exp(p-p.*t)./(q+p.*t);

SOP2 = ((c*j)/2).*(i1-i2);

semilogy(snr_dB, SOP2);
xlabel('Destination average SNR');
ylabel('Secrecy Outage Probability');

%%  this is the weibull fading channel for c = 4
c = 4;
Cth = 1;
t = 2^Cth;

q = gamma(1+2/c)/eavesdropper_avgSNR;
p = gamma(1+2/c)./destination_avgSNR;
j = (c/2)*(gamma(1+c/2)/eavesdropper_avgSNR);

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
semilogy(snr_dB, SOP4);
hold off;

legend('c=2', 'c=4', 'Location', 'Northeast');
grid on;


