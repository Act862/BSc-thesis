% Set parameters
snr_dB = -10:2:30; % range of SNR values in dB
num_simulations = 10000; % number of Monte Carlo simulations
thresholdCapacity = 1;
lambda = 2^thresholdCapacity;
 
% Convert SNR range to linear scale
avgSNR_dest = 10.^(snr_dB/10);
avgSNR_eve = 10;
 
% Calculate theoretical outage probability for each SNR value

f1 = exp((-lambda+1)./avgSNR_dest);
f2 = avgSNR_dest./(lambda.*avgSNR_eve+avgSNR_dest);

P_out_theory = 1 - f1.*f2;
 
% Initialize arrays to store simulation results
P_out_sim = zeros(size(avgSNR_dest));

% Perform Monte Carlo simulations
for i = 1:length(avgSNR_dest)
    % Generate complex Gaussian channel with Rayleigh fading
    h1 = (randn(num_simulations, 1) + 1i * randn(num_simulations, 1)) / sqrt(2);
    h2 = (randn(num_simulations, 1) + 1i * randn(num_simulations, 1)) / sqrt(2);
    % Calculate received signal power and noise power
    rx_power = abs(h1).^2 .*avgSNR_dest(i);
    eve_power = abs(h2).^2*avgSNR_eve;
    % Calculate outage events
    outage = (rx_power < eve_power.*lambda);
    % Calculate probability of outage
    P_out_sim(i) = sum(outage) / num_simulations;
end
 
% Plot results
semilogy(snr_dB, P_out_theory, 'b-', 'LineWidth', 2);
hold on;
semilogy(snr_dB, P_out_sim, 'r*', 'MarkerSize', 5);
grid on;
xlabel('Destination SNR (dB)');
ylabel('Secrecy Outage Probability');
legend('Theoretical', 'Simulation');
