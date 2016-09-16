% This function creates a random message matrix of size KxK. Parity bits
% are also added, making the matrix Kx2K (TODO: this should be n; check)
function encodedMatrix = encoder (n, k, dmin)
msg = [];
for i =1 : k
    % create random msg matrix
    msg_string = randi([0 1], 1, k);   
    msg = [msg; msg_string];
end

% Parity bit logic: All rows in the matrix are added (using xor) except for
% the row indicated by rowToNotAdd. This is the very last row for the very
% first parity bits row, 2nd last row for the 2nd parity bits row and so on

% Initialize rowToNotAdd as k, the last row in the message matrix
rowToNotAdd = k;
parityMatrix = [];
for j = 1: k
    % parity row initialized as a row of zeros. Any row xor'd with 0's
    % gives us the row. This is needed for the very first iteration of the
    % for loop
    parity = zeros(1, k);
    
    % Loop responisble for performing parity additions 
    for s = 1: k
        % creating parity bits        
        if (s == rowToNotAdd)
            %dont add
        else
            %add
            parity = xor(parity, msg(s,:));
        end
    
    end
    % create a parityMatrix for each parity rows
    parityMatrix = [parityMatrix; parity];
    rowToNotAdd = rowToNotAdd - 1;
end

% append parityMatrix to msg matrix to create the final matrix according to
% the specified encoding schema
msg = [msg parityMatrix];

% print out for debugging
finalMsg = msg

end