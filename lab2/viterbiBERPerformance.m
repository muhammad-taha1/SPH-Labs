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
BER = [];
decodingErrors = 0;

for i = 1: 11
    for k = 1 : 10000
        noise = std_deviation(i)*randn(1,8); 
        msg_string = randi([0 1], 1, 4);
        codeword = eightFourFourEncoder(msg_string); 
        receviedMessage = noise + codeword;
        decodedMessage = ViterbiDecoder(receviedMessage); 

%% BER of message
% Calculated by taking number of incorrect message bits and dividing them by the
% total size of the message.

        errorBits = 0; 
        for l= 1 :4
            if (codeword(l) ~= decodedMessage(l))
                errorBits = errorBits + 1; 
            end 
        end
        BER = [BER, errorBits / 4]; 
        if( errorBits ~= 0)
            decodingErrors = decodingErrors + 1; %decoding errors are counted when a codeword has one or more errors. 
        %decodingErrors  = decodingErrors + errorBits;
        end 
        if(decodingErrors >= 100) 
            break; 
        end 
    end
    averageBER(i) = mean(BER);
    decodingErrors = 0;
    BER = [];
end

%% Plot BER vs SNR 
% Relevant values of BER to different SNR levels from 0 to 10 dB. 
% Uses semilog y to plot 

x = SNR_dB;  
%y = log10(averageBER); 
y = averageBER; 
figure 
semilogy(x,y)
xlabel('SNR')
ylabel('BER')
title('BER vs. SNR for Viterbi Decoder')
