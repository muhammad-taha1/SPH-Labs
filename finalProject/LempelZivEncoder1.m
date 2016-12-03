function [encoded, dictionary] = LempelZivEncoder1(input, n)
% This function applies LempelZiv encoding on the input. This is the first
% implementation version, so input window size is fixed along with block
% size. n indicates the block size, which will be compared. 

%% The following section deals with overhead computations for LempelZiv
% compute prob for each symbol, for Hx calculation. Assume that the input
% only has two symbols, 0 and 1.

p0 = 0;
p1 = 0;
for i = 1 : length(input)
    if (input(i) == 0)
        p0 = p0 + 1;
    else
        p1 = p1 + 1;
    end
end

p0 = p0/length(input);
p1 = p1/length(input);

% Hx formula taken from dp1 report
Hx = p0*log2(1/p0) + p1*log2(1/p1);

% W is the window size according to formula provided by Proff
w = n^2*(2^(n*Hx));
% floor this value, can't have a window size in decimals
w = floor(w);

% TODO: need to make dictionary depend on w. double check the expectations 
% v1 algo. Currently, the dictionary kind of looks over the entire input

%% Begin encoding

% initialize empty dictionary. The first n bits of dictionary will store
% the unique blocks encountered in the input. The last bit of dictionary
% will store the block's relative position in the input. The dictionary
% will be a matrix, containing all unique blocks and length of each row in
% the dictionary will be n+1
dictionary = [];

% result of encoding. Its a matrix, where size of each row is 2. First bit
% is the flag, which is 1 if the block is a repition from before (exists in
% dictionary) and 0 if its a new block symbol. The next bit indicates the
% relative position of the block in dictionary
encoded = [];

% loop over input by incrementing in steps of n
for i = 1 : n : length(input)
    % current block is the n bits from i.
    currentBlock = input(i:i+n-1);
    
    % this variable is true when the currentBlock is found in dictionary
    blockFound = false;
    
    [rowSize, ~] = size(dictionary);
    for j = 1 : rowSize
        % loop over dictionary and look for current block
        if (currentBlock == dictionary(j,1:n))
            % current block found in dictionary. Stop looking any further
            % and store the result in output
            encoded = [encoded; [1 j]];
            blockFound = true;
            break;
        end
    end
    
    % add stuff to dictionary. Only add if block is not found in dictionary
    % or if the dictionary is empty
    if (isempty(dictionary) || ~blockFound)
        dictionary = [dictionary; [currentBlock i]];
        
        % add the block in encoded string too. Since we append in
        % dictionary, we should append the last index from dictionary
        % matrix here, since this block will exist only at the very last
        % index at this point in dictionary
        [rowSize, ~] = size(dictionary);
        encoded = [encoded; [0 rowSize]];
    end
end

%% Encoding done! outputs should be dictionary and encoded
end