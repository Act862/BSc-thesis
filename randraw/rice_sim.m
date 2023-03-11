clear all;
clc;
%%  generate a random sequence of 1000 numbers and send it over a rayleigh channel
%   1. define the parameters of the simulation
noiseSNRdb = 20;
nonCentralityParameter = 1;
scaleParameter = 3;
% size = [1 1e5];
sampleSize = [1 1e4];
noisePower = 1;
threshold = 1;

%    Get a modulator object
bpskMod = comm.BPSKModulator;
%    Setup the phase offset of the modulation
bpskMod.PhaseOffset = pi/16;

bpskDemod = comm.BPSKDemodulator;
bpskDemod.PhaseOffset = pi/16;

sop = [];
kdbs = [];
transmissions_number = 1000;

for i=1:transmissions_number
%  2. generate the binary data (SOURCE)
data = randi([0 1], sampleSize);

% 3. modulate the data into symbols
%    we have only two possible data values (0,1) thus
%    we are going to use the BPSK modulation scheme
%    modulate the data and generate the symbols
symbols = bpskMod(data')';

%   4. channel gains
%   we are going to generate one channel gain for each receiver
channelGain_d = randraw('rice', [nonCentralityParameter scaleParameter], sampleSize);
channelGain_e = randraw('rice', [nonCentralityParameter scaleParameter], sampleSize);

%   5. calculate the received symbol (r = h*s)
received_d = channelGain_d.*symbols;
received_e = channelGain_e.*symbols;

%   6. add noise to the symbols
%   r = h*s + n
received_d_with_noise = awgn(received_d, noiseSNRdb);
received_e_with_noise = awgn(received_e, noiseSNRdb);

%   7. demodulate to the destination
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

% snr_destination = abs(received_d_with_noise.^2)/noisePower;
% snr_eavesdropper = abs(received_e_with_noise.^2)/noisePower;

% snr_destination_db = 10*log10(snr_destination);
% snr_eavesdropper_db = 10*log10(snr_eavesdropper);

%   9. calculate the SOP
K = snr_destination./snr_eavesdropper;
Kdb = 10*log10(K);

count = sum(Kdb < threshold);
sop = [sop count/sampleSize(2)];

K = mean(snr_destination)/mean(snr_eavesdropper);
Kdb = 10*log10(K);
kdbs = [kdbs mean(snr_destination)];
end

semilogy(kdbs, sop, '.');
ylabel('Secrecy Outage Probability');
xlabel('Destination to Eavesdropper ratio K (dB)');
grid on;



