% Define the parameters of the Rayleigh distribution
sigma = 2;

% Define the secrecy threshold
threshold = 1;

% Generate a sample of channel gains from the Rayleigh distribution
n_samples = 1000;
channel_gains = raylrnd(sigma, n_samples, 1);

% Calculate the secrecy capacity for each channel gain
noise_power = 1; % Assume that the noise power is 1
secrecy_capacity = max(0, channel_gains - noise_power);

% Calculate the secrecy outage probability
secrecy_outage_probability = sum(secrecy_capacity < threshold) / n_samples;