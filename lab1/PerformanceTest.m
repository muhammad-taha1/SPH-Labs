function PerformanceTest
prob = 0.1;
PerrorToPlot = [];
BER_Gaussian_ToPlot = [];
BER_Exhaustive_ToPlot = [];

while (prob < 0.8)
    BER_GaussianAvg = 0;
    BER_ExhaustiveAvg = 0;
    % Repeat below process for each probability, 3 times
    for rep = 1 : 100
        msg = [];
        for i =1 : 3
            % create random msg matrix
            msg_string = randi([0 1], 1, 3);
            msg = [msg; msg_string];
        end
        % count for incorrect bits for BER, per message
        incorrectBits_Gaussian = 0;
        incorrectBits_Exhaustive = 0;
        BER_Gaussian = 0;
        BER_Exhaustive = 0;
        
        encodedMatrix = encoder(6, 3, 3, msg);
        outputMatrix = ErasureChannel(encodedMatrix, prob);
        outputMatrix
        gaussianAns = Gaussian_Decoder(outputMatrix)
        exhaustiveAns = decoder(outputMatrix);
        
        % Check gaussian decoder
        for row = 1 : 3
            for col = 1 : 3
                if (encodedMatrix(row, col) ~= gaussianAns(row, col))
                    incorrectBits_Gaussian = incorrectBits_Gaussian + 1;
                end
                
                % Check exhaustive decoder
                if (encodedMatrix(row, col) ~= exhaustiveAns(row, col))
                    incorrectBits_Exhaustive = incorrectBits_Exhaustive + 1;
                end
            end
        end
        
        BER_Gaussian = incorrectBits_Gaussian/9;
        BER_Exhaustive = incorrectBits_Exhaustive/9;
        
        BER_GaussianAvg = BER_GaussianAvg + BER_Gaussian;
        BER_ExhaustiveAvg = BER_ExhaustiveAvg + BER_Exhaustive;
    end
    
    BER_GaussianAvg = BER_GaussianAvg/100;
    BER_ExhaustiveAvg = BER_ExhaustiveAvg/100;
    
    PerrorToPlot = [PerrorToPlot; prob];
    BER_Gaussian_ToPlot = [BER_Gaussian_ToPlot; BER_GaussianAvg];
    BER_Exhaustive_ToPlot = [BER_Exhaustive_ToPlot; BER_ExhaustiveAvg];
    prob = prob + 0.05;
end

% Now make plots
figure
plot(PerrorToPlot, BER_Gaussian_ToPlot)
xlabel('Probability of error')
ylabel('BER - Gaussian')
title('Gaussian Decoder Performance')

figure
plot(PerrorToPlot, BER_Exhaustive_ToPlot)
xlabel('Probability of error')
ylabel('BER - Exhaustive')
title('Exhaustive Decoder Performance')
end