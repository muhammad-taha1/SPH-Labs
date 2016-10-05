function corruptedMatrix = ErasureChannel(encodedMatrix, Perror)
finalMatrix = [];
messageSize = size(encodedMatrix);

% Loop over the message
for i=1: messageSize(1)
    % Generate random erasure vectors with probability lower than Perror
    errorVector = (-0.5) * (rand(1, messageSize(2)) < Perror);
    % Add the errors to the encoded matrix and append to final result.
    finalMatrix = [finalMatrix; abs(encodedMatrix(i,:) + errorVector)];
end

corruptedMatrix = finalMatrix;

end
