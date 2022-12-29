% Define the parameters of the system
n_bits = 1000;
modulation = 'BPSK';
noise_snr_db = 20;

% Generate a sample of random bits
bits = randi([0 1], n_bits, 1);
% Modulate the bits using BPSK
symbols = pskmod(bits, 2);

% Generate a sample of channel gains from the Rayleigh distribution
sigma = 1; % Define the scale parameter of the Rayleigh distribution
channel_gains_destination = raylrnd(sigma, n_bits, 1);
channel_gains_eavesdropper = raylrnd(sigma, n_bits, 1);

% Calculate the received signal at the destination and the eavesdropper
received_signal_destination = symbols .* channel_gains_destination;
received_signal_eavesdropper = symbols .* channel_gains_eavesdropper;

% Add noise to the received signal
received_signal_destination_with_noise = awgn(received_signal_destination, noise_snr_db);
received_signal_eavesdropper_with_noise = awgn(received_signal_eavesdropper, noise_snr_db);

% Demodulate the received signal at the destination and the eavesdropper
received_bits_destination = pskdemod(received_signal_destination_with_noise, 2);
received_bits_eavesdropper = pskdemod(received_signal_eavesdropper_with_noise, 2);

% Calculate the SNR of the received signal at the destination and the eavesdropper
noise_power = 1; % Assume that the noise power is 1
snr_destination = mean(channel_gains_destination.^2) / noise_power;
snr_eavesdropper = mean(channel_gains_eavesdropper.^2) / noise_power;

% Calculate the secrecy outage probability
threshold = 1; % Define the threshold for the ratio of the SNRs
ratio_snrs = snr_destination / snr_eavesdropper;
secrecy_outage_probability = sum(ratio_snrs < threshold) / n_bits;
