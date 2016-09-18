function outputMatrix = SystemTest(Perror)
   
    encodedMatrix = encoder(6,3,3); 
    x = encodedMatrix 
    outputMatrix = ErasureChannel(encodedMatrix, Perror); 
    
    decodedMatrix = decoder(outputMatrix); 
end 
