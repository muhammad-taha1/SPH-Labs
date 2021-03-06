function [encoded, P_match] = LempelZivEncoder1(input, n, w)
% This function applies LempelZiv encoding on the input. This is the first
% implementation version, so input window size is fixed along with block
% size. n indicates the block size, which will be compared. w sets the max
% window size
%% Begin encoding

% Intialize window to size w. Assumption is that the window would contain all
% possible combos in input?
window = [];

% result of encoding. Its a matrix, where size of each row is 1 + log2(W/n) . First bit
% is the flag, which is 1 if the block is a repition from before (exists in
% window) and 0 if its a new block symbol. The next bit indicates the
% relative position of the block in window
encoded = [];
pointer = []; 
% value to slide our window with
windowSlide = 1;
%Probability that the symbol matches a word 
P_match = 0; 
% loop over input by incrementing in steps of n
for i = 1 : n : length(input)
    % current block is n bits from i.
    currentBlock = input(i:i+n-1);
    
    % this variable is true when the currentBlock is found in window
    blockFound = false;
    
    for j = 1 : n: length(encoded)
        % loop over encoded string and look if it exists in window
        if ((j+n-1 <= length(window)) & (currentBlock == window(j:j+n-1)))
            % current block found in dictionary. Stop looking any further
            % and store the result in output. Set flag to 1 and the
            % pointer in window at each n block of where the block exists
            pointer = decimalToBinary(ceil(j/n) - 1, ceil(log2(w/n))); 
            encoded = [encoded, [1 pointer]];
            blockFound = true;
            P_match = P_match + 1; 
            break;
        end
    end
    
    % case where block is not found in encoder. Set flag to 0 and the next
    % n bits to the currentBlock
    if (~blockFound)
        encoded = [encoded, [0 currentBlock]];
    end
    
    % add current block to window. Window max size has to be w, after that
    % it should slide. Window should be smaller than the input data
    if (i < w)
        window = [window, currentBlock];
    end
end
% Divide the number of matches by total number of symbols
P_match = P_match / (length(input)/n);
%% Encoding done! output should be encoded binary.
end