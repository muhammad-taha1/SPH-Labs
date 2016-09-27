function CorruptedMessage = Pflip_Error_Channel(SentMessage, Pflip)
    
    tempOutputMatrix = []; 
    
    sizeOfMessage = size(SentMessage); 
    
    errorVector  = rand (1, sizeOfMessage(2)) < Pflip; 
 errorVector
    for k = 1: sizeOfMessage(1) 
        tempOutputMatrix = [tempOutputMatrix; mod(errorVector + SentMessage(k,:), 2)];  
    end
    
    CorruptedMessage  = tempOutputMatrix; 
end 
