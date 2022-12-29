clear all;
clc;
%%  generate a random sequence of 1000 numbers and send it over a rayleigh channel
%   1. define the parameters of the simulation
noiseSNRdb = 20;
scaleParam = 1;
% size = [1 1e5];
sampleSize = [1 1e3];
noisePower = 1;
threshold = 1;

%  2. generate the binary data (SOURCE)
data = randi([0 1], sampleSize);

% 3. modulate the data into symbols
%    we have only two possible data values (0,1) thus
%    we are going to use the BPSK modulation scheme
%    Get a modulator object
bpskMod = comm.BPSKModulator;
%    Setup the phase offset of the modulation
bpskMod.PhaseOffset = pi/16;
%    modulate the data and generate the symbols
symbols = bpskMod(data');

%   4. channel gains
%   we are going to generate one channel gain for each receiver
channelGain_d = randraw('rayl', scaleParam, sampleSize);
channelGain_e = randraw('rayl', scaleParam, sampleSize);

%   5. calculate the received symbol (r = h*s)
received_d = channelGain_d.*symbols;
received_e = channelGain_e.*symbols;

%   6. add noise to the symbols
%   r = h*s + n
received_d_with_noise = awgn(received_d, noiseSNRdb);
received_e_with_noise = awgn(received_e, noiseSNRdb);

%   7. demodulate to the destination
bpskDemod = comm.BPSKDemodulator;
bpskDemod.PhaseOffset = pi/16;

received_data_d = zeros(size(received_d_with_noise));
received_data_e = zeros(size(received_e_with_noise));

for i=1:numel(received_d_with_noise)
    received_data_d(i) = bpskDemod(received_d_with_noise(i));
end

for i=1:numel(received_data_d)
    received_data_e(i) = bpskDemod(received_e_with_noise(i));
end

% disp(received_data_d);
% disp(received_data_e);

%   8. calculate the snr of a sample of symbols.
snr_destination = (channelGain_d.^2)./noisePower;
snr_eavesdropper = (channelGain_e.^2)./noisePower;

%   9. calculate the SOP
K = snr_destination./snr_eavesdropper;
Kdb = 10*log10(K);
secrecy_outage_probability = [];

for i=1:length(Kdb)
    secrecy_outage_probability = [secrecy_outage_probability sum(Kdb(i) < threshold) / 1e3];
end

semilogy(Kdb, secrecy_outage_probability, 'o');



