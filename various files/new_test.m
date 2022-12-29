% Define the parameters of the system
sampleSize = 1000;
modulation = 'BPSK';
noiseSNRdb = 20;


% Generate a sample of random bits
data = randi([0 1], sampleSize, 1);

% Modulate the bits using BPSK
symbols = pskmod(data, 2);

% Generate a sample of channel gains from the Rayleigh distribution
sigma = 1; % Define the scale parameter of the Rayleigh distribution
channel_gains = raylrnd(sigma, sampleSize, 1);

% Calculate the received signal
received_signal = symbols .* channel_gains;

% Add noise to the received signal
received_signal_with_noise = awgn(received_signal, noiseSNRdb);

% Demodulate the received signal
received_bits = pskdemod(received_signal_with_noise, 2);

% Calculate the bit error rate
ber = sum(data ~= received_bits) / sampleSize;

% Calculate the secrecy outage probability
secrecy_outage_probability = sum(ber > 0) / sampleSize;
