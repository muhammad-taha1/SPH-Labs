function DecodedOutput = EightFourFourCodeDecoder(receivedCodeword) 
%% Codebook 
%Generator matrix is iddentity matrix with parity bits. 
clc

G = [1 0 0 0 1 1 1 0; 0 1 0 0 1 1 0 1; 0 0 1 0 1 0 1 1; 0 0 0 1 0 1 1 1]; 

codebook = []; 

for b1 = 0: 1
    for b2 = 0 : 1
        for b3 = 0 : 1
            for b4 = 0 : 1
            b = [b1 b2 b3 b4];
            codebook = [codebook; mod(b*G, 2)];
            end
        end
    end
end
codebook
cbSize = size(codebook); 
distanceVector = [] ;
contiansError = false; 
squaredDistance = 0; 
%% Loop to find minimum distanace 
% Loops over the codebook and computes distance to received codeword by
% taking sum of (ri -ci)^2

    for n = 1  : cbSize(1) 
        distance = receivedCodeword(1,:) - codebook(n,:);
        for k = 1 : 8 %number of columns in distance row 
            %if(k < 8) 
            %if(abs(distance(k)) == 1) 
            %    distanceVector = [distanceVector; inf]; 
            %    break; 
            %else
            %    containsError = true; 
                squaredDistance = squaredDistance + distance(k)^2;
            %end 
            %else %((k == 8) && containsError) 
            %    distanceVector = [distanceVector; squaredDistance]; 
            %    squaredDistance = 0;
           %end 
        end 
              distanceVector = [distanceVector; squaredDistance]; 
              squaredDistance = 0;
    end 
    
%% Find codeword with minimum distance   
    minIndex = find(distanceVector == min(distanceVector(:)));
%% Match codeword
% Use the minimum distance to extract codeword(s) from codebook 
    outputCodeword = []; 
    
    for j =1 : size(minIndex) 
        outputCodeword = [outputCodeword; codebook(minIndex(j),:)]; 
    end
    
    DecodedOutput = outputCodeword; 
    
end