function decodedMessage = SyndroneDecoder(ReceivedMessage)

    syndrome = [];
    error_matrix = [];
    c_hat = []; 
    messageSize = size(ReceivedMessage); 
    
    H = [ 1 1 0 1 0 0; 1 0 1 0 1 0; 0 1 1 0 0 1]; 
    
    errorTable = [  0 0 0 0 0 0; 
                    0 0 0 0 0 1;
                    0 0 0 0 1 0; 
                    0 0 0 1 0 0; 
                    0 0 1 0 0 0; 
                    0 1 0 0 0 0; 
                    1 0 0 0 0 0 ] ; 
    
    SyndromeTable = [ H* errorTable(1,:)', H* errorTable(2,:)', H* errorTable(3,:)', H* errorTable(4,:)', H* errorTable(5,:)', H* errorTable(6,:)', H* errorTable(7,:)'];

    for k = 1: messageSize(1)
        syndrome = [syndrome, mod(H* ReceivedMessage(k,:)', 2)];  
       for i = 1: 7 
            if (syndrome(:, k) == SyndromeTable(:, i)); 
                error_matrix = [ error_matrix; errorTable(i, :)]; 
            end
       end
    end
    
    c_hat = mod( ReceivedMessage - error_matrix, 2); 
    decodedMessage = c_hat; 
end