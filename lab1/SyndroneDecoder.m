function decodedMessage = SyndroneDecoder(ReceivedMessage)

syndrome = [];
error_matrix = [];
c_hat = [];
messageSize = size(ReceivedMessage);

% H matrix
H = [ 1 1 0 1 0 0; 1 0 1 0 1 0; 0 1 1 0 0 1];

% single error table for (6,3,3) code
errorTable = [  0 0 0 0 0 0; 0 0 0 0 0 1; 0 0 0 0 1 0; 0 0 0 1 0 0;
    0 0 1 0 0 0; 0 1 0 0 0 0; 1 0 0 0 0 0 ] ;

% Form the syndrome table via: H*errorTable'
SyndromeTable = [ H* errorTable(1,:)', H* errorTable(2,:)', ...
    H* errorTable(3,:)', H* errorTable(4,:)', H* errorTable(5,:)',...
    H* errorTable(6,:)', H* errorTable(7,:)'];

% Loop over the received matrix
for k = 1: messageSize(1)
    % Initialize errorNotFound as true
    errorNotFound = true;
    % Syndrome is computed H* ReceivedMessage' for each row
    syndrome = [syndrome, mod(H* ReceivedMessage(k,:)', 2)];
    for i = 1: 7
        % Compare the obtained syndrome against all the syndromes from the
        % syndrome table. 
        if (syndrome(:, k) == SyndromeTable(:, i));
            % If error is found in the table, add the corresponding error
            % to error matrix and set errorNotFound as false
            error_matrix = [error_matrix; errorTable(i, :)];
            errorNotFound = false;
        end
    end
    if (errorNotFound)
        % If no error is found, a zero vector is appended instead to the
        % error matrix. This is done to ensure the decoder returns the same
        % message when its not able to decode
        error_matrix = [error_matrix; zeros(1,messageSize(2))];
    end
end

% Substract errors from received matrix to get the decoded result
c_hat = mod( ReceivedMessage - error_matrix, 2);
decodedMessage = c_hat;
end