function decodedMatrix = SystemTest(n, k, dmin, Perror)
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
    encodedMatrix
    outputMatrix
    gaussianAns = Gaussian_Decoder(outputMatrix)
    decodedMatrix = decoder(outputMatrix); 
end 
