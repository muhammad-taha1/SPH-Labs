function decodedMatrix = decoder(receivedMatrix) 
    codeBook = []; 
  
    messageSize = size(receivedMatrix); 
    numberOfCodewords = 2^ (messageSize(2));
    
    for i = -1: numberOfCodewords - 2 
       codeword = dec2bin(i +1);
       sizeOfCodeword = size(codeword); 
       if(sizeOfCodeword(2) ~= messageSize(2))
          extraZeros = '';
           for j = 1: messageSize(2) - sizeOfCodeword(2)
               extraZeros = strcat(extraZeros,'0'); 
           end
           codeword = strcat(extraZeros, codeword); 
       end
       y = codeword
       codeBook = [codeBook; codeword]; 
    end
    
 %Exhaustive Search % 
    for i = 1 : messageSize(1) 
      %  check using if statement before going into the exhaustive search 
        for j = 1 : numberOfCodewords
        end
    end 
    
end 
