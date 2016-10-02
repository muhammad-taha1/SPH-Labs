%% Exhaustive Decoder
% Exhaustive search decoder
%%
function decodedMatrix = decoder(receivedMatrix)
messageSize = size(receivedMatrix);

codeBook = [];
% identity matrix with parity bits
G = [ 0 0 1 0 1 1; 0 1 0 1 0 1; 1 0 0 1 1 0];
%G = [ 0 0 0 1 0 1 1 1; 0 0 1 0 1 0 1 1; 0 1 0 0 1 1 0 1; 1 0 0 0 1 1 1 0];
% form codebook
 
for b1 = 0: 1
    for b2 = 0 : 1
        for b3 = 0 : 1
            %for b4 = 0 : 1
            b = [b1 b2 b3];
            codeBook = [codeBook; mod(b*G, 2)];
            %end
        end
    end
end

codeBook
DecodedResult = [];
%Exhaustive Search %
tic
for i = 1 : messageSize(1)
    % loop over message
    cbSize = size(codeBook);
    distancePerCw = [];
    
    for j = 1 : cbSize(1)
        % loop over all codewords in codebook and calculate difference
        difference = receivedMatrix(i,:) - codeBook(j,:);
        differenceSize = size(difference);
        rowContainsError = false;
        for k = 1 : differenceSize(2)
            % loop over all bits in the difference vector
            if ((difference(1, k) == -1) | (difference(1, k) == 1))
                difference(1, k) = inf;
            end
            
            % check if difference contains |0.5|. If not, then the
            % receivedMatrix at i, is not corrupted and hence this row
            % should not be decoded and returned as is by the decoder
            if ((difference(1, k) == -0.5) | (difference(1, k) == 0.5))
                rowContainsError = true;
                difference(1,k) = difference(1,k) ^ 2; %this is a sqaured sum.  
            end
        end
        % store the sum of difference in distancePerCw vector - This vector
        % at this point, should contain the distances of message at i
        % against all the vectors in the codebook
        distancePerCw = [distancePerCw; sum(difference)];
    end
    
    % Take minimum distance. Take multiple values if more than 1 min exists
    idx = find(distancePerCw(:) == min(distancePerCw));
    % TODO: Problem! If all entries in distancePerCw happens to be same 
    % (Inf), then it returns the entire codebook! Discuss
    
    % at this point we know all the min distances between receivedMatrix at
    % i against all codewords
    
    % forming Decoded Output
    if (rowContainsError) 
        for j = 1 : size(idx)
            % Take the value of codeBook at the index specified by distance
            % vector and append to DecodedResult
            DecodedResult = [DecodedResult; codeBook(idx(j), :)];   
        end
    else
        % if row contains no error, just append the row at DecodedResult!
        DecodedResult = [DecodedResult; receivedMatrix(i, :)];
    end
end
toc
decodedMatrix = DecodedResult;
