function PerformanceTest
prob = 0.1;
PerrorToPlot = [];
BER_Gaussian_ToPlot = [];
BER_Exhaustive_ToPlot = [];

while (prob < 0.8)
    BER_GaussianAvg = 0;
    BER_ExhaustiveAvg = 0;
    % Repeat below process for each probability, 1000 times
    for rep = 1 : 1000
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
        [exhaustiveAns, decodingPerRow] = decoder(outputMatrix);
        
        % Check for exhaustive decoder's success by comparing all possible
        % outputs it returns - Consider only the message bits
        exhaustiveAns = exhaustiveAns(: , 1:3)
        decodingPerRow
        % Loop over all the decodingPerRow, to check how many rows exist
        % for each decoded row
        
        % Maintain 2 counts - one for decodingPerRow, other for exhaustiveAns
        RowIdx = 1;
        decPerRowCount = 1;
        while (RowIdx < length(exhaustiveAns))
            % if only one row was decoded for the corresponding output row
            if (decodingPerRow(decPerRowCount) == 1)
                for col = 1 : 3
                    if (encodedMatrix(decPerRowCount, col) ~= exhaustiveAns(RowIdx, col))
                        incorrectBits_Exhaustive = incorrectBits_Exhaustive + 1;
                    end
                end
                RowIdx = RowIdx + 1;
                % remove the rows which are checked
                %exhaustiveAns = exhaustiveAns(decRow:length(exhaustiveAns), :)
                
            else
                % here we check all the rows the decoder returned. Maybe it
                % was able to zoom in and correct some of the bits
                RowsToCheck = exhaustiveAns(RowIdx:RowIdx+decodingPerRow(decPerRowCount)-1, :);
                incorrectBits_Exhaustive = incorrectBits_Exhaustive + 3 - sum(max(RowsToCheck)- min(RowsToCheck) == 0);
                RowIdx = RowIdx + decodingPerRow(decPerRowCount);
            end
            decPerRowCount = decPerRowCount + 1;
            
        end
        
        % Check gaussian decoder
        for row = 1 : 3
            for col = 1 : 3
                if (encodedMatrix(row, col) ~= gaussianAns(row, col))
                    incorrectBits_Gaussian = incorrectBits_Gaussian + 1;
                end         
            end
        end
        
        BER_Gaussian = incorrectBits_Gaussian/9;
        BER_Exhaustive = incorrectBits_Exhaustive/9;
        
        BER_GaussianAvg = BER_GaussianAvg + BER_Gaussian;
        BER_ExhaustiveAvg = BER_ExhaustiveAvg + BER_Exhaustive;
    end
    
    BER_GaussianAvg = BER_GaussianAvg/1000;
    BER_ExhaustiveAvg = BER_ExhaustiveAvg/1000;
    
    PerrorToPlot = [PerrorToPlot; log10(prob)];
    BER_Gaussian_ToPlot = [BER_Gaussian_ToPlot; log10(BER_GaussianAvg)];
    BER_Exhaustive_ToPlot = [BER_Exhaustive_ToPlot; log10(BER_ExhaustiveAvg)];
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