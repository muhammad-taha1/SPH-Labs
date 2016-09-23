function corruptedMatrix = ErasureChannel(encodedMatrix, Perror)
    finalMatrix = []; 
    messageSize = size(encodedMatrix); 
    errorVector = (-0.5) * (rand(1, messageSize(2) ) < Perror);   

   for i=1: messageSize(1)
       finalMatrix = [finalMatrix; abs(encodedMatrix(i,:) + errorVector)]; 
   end
   
   corruptedMatrix = finalMatrix; 

end
