function SystemTest(n, k, dmin, Perror)

correctGaussian = 0;
correctExhaustive = 0;

for iteration = 1 : 100
    
    msg = [];
    for i =1 : k
        % create random msg matrix
        msg_string = randi([0 1], 1, k);
        msg = [msg; msg_string];
    end
    
    encodedMatrix = encoder(n, k, dmin, msg);
    outputMatrix = ErasureChannel(encodedMatrix, Perror);
    
    % This will print the corrupted msg as outputMatrix, encoded message
    % as encodedMatrix, output from Gaussian_Decoder as gaussianAns and ans
    % as output from exhaustive decoder.
    
    %encodedMatrix
    %outputMatrix
    gaussianAns = Gaussian_Decoder(outputMatrix);
    exhaustiveAns = decoder(outputMatrix);
    
    if (encodedMatrix == gaussianAns)
        correctGaussian = correctGaussian + 1;
    end
    
    if (encodedMatrix == exhaustiveAns(1 : 3, :))
        correctExhaustive = correctExhaustive + 1;
    end
end

b = bar([correctGaussian, correctExhaustive, 100], 0.4);

set(gca,'XTickLabel',{'Gaussian Decoder', 'Exhaustive Decoder', 'Total'})
title('Decoder performance comparison with Pe = 0.8')

end
