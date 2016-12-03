function [encoded, window] = LempelZivEncoder1(input, n)
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
% ceil this value, can't have a window size in decimals
w = ceil(w);

%% Begin encoding

% Intialize window to size w. Assumption is that the window would contain all
% possible combos in input?
window = input(1:w);

% result of encoding. Its a matrix, where size of each row is 2. First bit
% is the flag, which is 1 if the block is a repition from before (exists in
% window) and 0 if its a new block symbol. The next bit indicates the
% relative position of the block in window
encoded = [];

% value to slide our dictionary with
dictSlide = 1;
% loop over input by incrementing in steps of n
for i = 1 : n : length(input)
    % current block is n bits from i.
    currentBlock = input(i:i+n-1);
    
    % this variable is true when the currentBlock is found in dictionary
    blockFound = false;
    
    [rSize, ~] = size(encoded);
    for j = 1 : n: rSize
        % loop over encoded string and look if it exists in dictionary
        if ((j+n-1 < length(window)) & (currentBlock == window(j:j+n-1)))
            % current block found in dictionary. Stop looking any further
            % and store the result in output
            encoded = [encoded; [1 j]];
            blockFound = true;
            break;
        end
    end
    
    % case where block is not found in encoder. The i here should indicates
    % the position of the block in dictionary
    if (~blockFound)
        encoded = [encoded; [0 i]];
    end
    
    % slide the dictionary
    if (i > length(window))
        window = input(1+dictSlide:w);
        dictSlide = dictSlide + 1;
    end
end

%% Encoding done! outputs should be dictionary and encoded
w
encoded
end