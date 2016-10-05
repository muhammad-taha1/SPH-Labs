function CorruptedMessage = Pflip_Error_Channel(SentMessage, Pflip)

tempOutputMatrix = [];

sizeOfMessage = size(SentMessage);

% Loop over the message
for k = 1: sizeOfMessage(1)
    % generate errors (either a 0 or a 1 symbol) based on Pflip, Pflip
    % indicates the probability of obtaining a 1
    errorVector  = rand (1, sizeOfMessage(2)) < Pflip;
    % Add error vector to encoded message and append to output
    tempOutputMatrix = [tempOutputMatrix; mod(errorVector + SentMessage(k,:), 2)];
end

CorruptedMessage  = tempOutputMatrix;
end
