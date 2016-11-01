%% Viterbi BER performance 
% Generate plot of BER against SNR for Viterbi decoder. 

clc
clear all

%% Gaussian Noise 
% Gaussian Noise = mean + std_deviation*randn(1,N). 
% Set the noise variance such that SNR ranges between 0dB and 10dB with
% steps of 1dB. This can be rewritten as, for 8 bits: 
% y = 0 + randn(1,8) 

SNR_dB = [0 1 2 3 4 5 6 7 8 9 10];
SNR = 10.^(-SNR_dB./10); 
std_deviation = sqrt(SNR); 

for i = 1: 10
    for k = 0 : 100
        noise = std_deviation(i)*randn(1,8); 
        msg_string = randi([0 1], 1, 4);
        codeword = eightFourFourEncoder(msg_string); 
        receviedMessage = noise + codeword;
        decodedMessage = ViterbiDecoder(receviedMessage); 
        
    end 
end 

%% BER of message
% Calculated by taking number of incorrect message bits and dividing them by the
% total size of the message. Take log10() of this rate. 
for n= 1: 11
    msg_string = randi([0 1], 1, 4);
    codeword = eightFourFourEncoder(msg_string); 

end
%% 