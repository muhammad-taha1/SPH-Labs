function outputMatrix = SystemTest(n, k, dmin, Perror)
    msg = [];
    for i =1 : k
        % create random msg matrix
        msg_string = randi([0 1], 1, k);   
        msg = [msg; msg_string];
    end

    encodedMatrix = encoder(n, k, dmin, msg); 
    x = encodedMatrix 
    outputMatrix = ErasureChannel(encodedMatrix, Perror); 
    
    decodedMatrix = decoder(outputMatrix); 
end 
