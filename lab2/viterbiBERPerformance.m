%% Viterbi BER performance 
% Generate plot of BER against SNR for Viterbi decoder. 

%% Gaussian Noise 
% Gaussian Noise = mean +std_deviation*randn(1,N). 
% Set the noise variance such that SNR ranges between 0dB and 10dB with
% steps of 1dB. This can be rewritten as: 
% y = 5 + randn(1,N) 

figure 
x = [1:10]; 
SNR = 5 + randn(1, 10);
plot(x, SNR);

%% BER of message
% Calculated by taking number of incorrect message bits and dividing them by the
% total size of the message. Take log10() of this rate. 
for n= 1: 11
    msg_string = randi([0 1], 1, 4);
    codeword = eightFourFourEncoder(msg_string); 
    receivedSignal = 1/SNR(mod(n,10)+1)* codeword + codeword;
end
%% 