function SyndromeTester()
pFlip = [0.6 0.55 0.5 0.45 0.4 0.35 0.3 0.25 0.2 0.15 0.1 0.05 0.01];
BerToPlot = [];

for pr = 1 : length(pFlip)
    BerAvg = 0;
    % do 100 random messages for each probability
    for rep = 1 : 3000
        incorrectBits = 0;
        BER = 0;
        msg = [];
        
        for i = 1 : 3
            % create random msg matrix
            msg_string = randi([0 1], 1, 3);
            msg = [msg; msg_string];
        end
        
        encodedMatrix = encoder(6,3,3, msg)
        corruptedMatrix = Pflip_Error_Channel(encodedMatrix, pFlip(pr))
        decodedAns = SyndroneDecoder(corruptedMatrix)
        
        % Check decoder
        for row = 1 : 3
            for col = 1 : 3
                if (encodedMatrix(row, col) ~= decodedAns(row, col))
                    incorrectBits = incorrectBits + 1;
                end
            end
        end
        
        BER = incorrectBits/9;
        BerAvg = BerAvg + BER;
    end
    
    BerAvg = BerAvg/3000;
    BerToPlot = [BerToPlot; log10(BerAvg)];
end

% Now make plots
figure
plot(log10(pFlip), BerToPlot)
xlabel('Log10(Probability of flip) dB')
ylabel('Log10(BER - Syndrome) dB')
title('Syndrome Decoder Performance')
end