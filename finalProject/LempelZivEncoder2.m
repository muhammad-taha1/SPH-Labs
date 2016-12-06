function encoded = LempelZivEncoder2(input, n, w)
% This function applies LempelZiv version 2 encoding on the input.
% Input window size is fixed along with block size. n indicates the block size,
% which will be compared. In this version, we try to get a match of all
% block's of size n. The comparison is performed for every next block of
% size, i.e. block x1--xn, xn+1--x2n and so on
% w sets the max window size

%% Begin encoding

% Intialize window to size w. Assumption is that the window would contain all
% possible combos in input?
window = [];

% result of encoding. Its a matrix, where size of each row is 1 + log2(w) . First bit
% is the flag, which is 1 if the block is a repition from before (exists in
% window) and 0 if its a new block symbol. The next bit indicates the
% relative position of the block in window
encoded = [];
pointer = [];
% value to slide our window with
windowSlide = 1;
% loop over input by incrementing in steps of n
for i = 1 : n : length(input)
    % current block is n bits from i.
    currentBlock = input(i:i+n-1);
    
    % this variable is true when the currentBlock is found in window
    blockFound = false;
    
    % loop over encoded string and look if it exists in window
    for k = 1 : length(window)
        % loop over window and search for the block in window
        if ((k+n-1 < length(window)) & (currentBlock == window(k:k+n-1)))
            %ceil(k) - 1
            pointer = decimalToBinary(ceil(k) - 1, ceil(log2(w)));
            encoded = [encoded, [1 pointer]];
            blockFound = true;
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
    else
        % slide the window
        %      window = input(1+windowSlide:w+windowSlide);
        %      windowSlide = windowSlide + 1;
    end
end

%% Encoding done! output should be encoded binary.
end