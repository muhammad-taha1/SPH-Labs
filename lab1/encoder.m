% This function creates a random message matrix of size KxK. Parity bits
% are also added, making the matrix Kx2K (TODO: this should be n; check)
function encodedMatrix = encoder (n, k, dmin, msg)

% Parity bit logic: loop over all rows, p1 = sum of all bits except last in
% a row, p2 = sum of all bits except 2nd last in row and so on...

% Initialize rowToNotAdd as k, the last row in the message matrix
parityRow = zeros(k, n - k);
msg = horzcat(msg, parityRow);

for j = 1: n - k
    bitToNotAdd = n - k;
    % Loop over each bit in the matrix
    for i = 1: n - k
        parity = 0;
        
        % Loop sequentially generates each parity bit for a row
        for s = 1: n - k
            % Current parity
            % creating parity bits
            if (s == bitToNotAdd)
                %dont add
            else
                parity = mod(parity + msg(j, s), 2);
                %add
                % parity = mod(msg(s,:));
            end
            
        end
        msg(j, n - bitToNotAdd + 1) = parity;
        % create a parityMatrix for each parity rows
        %parityMatrix = [parityMatrix; parity];
        bitToNotAdd = bitToNotAdd - 1;
    end
end

encodedMatrix = msg;

end