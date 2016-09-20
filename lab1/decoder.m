%% DOCUMENT TITLE
% INTRODUCTORY TEXT
%%
function decodedMatrix = decoder(receivedMatrix) 
    messageSize = size(receivedMatrix);
    
    codeBook = []; 
    G = [ 0 0 1 0 1 1; 0 1 0 1 0 1; 1 0 0 1 1 0]; 
   
    for b1 = 0: 1
        for b2 = 0 : 1
            for b3 = 0 : 1
                b = [b1 b2 b3];
                codeBook = [codeBook; mod(b*G, 2)]; 
            end 
        end 
    end 
    
    x = codeBook
    distance = []; 
 %Exhaustive Search % 
    for i = 1 : messageSize[2]  
      %  check using if statement before going into the exhaustive search 
        for j = 1 : size(codeBook)[1]
            difference = receivedMatrix(i,:) - codeBook(j,:); 
            if ( (difference(1, i) == -1) | (difference(1, i) == 1))
                difference(1, j) = inf; 
            end
        end 
                distance = [distance; difference]; 

     y = distance
end 
