function CorruptedMessage = Pflip_Error_Channel(SentMessage, Pflip)

tempOutputMatrix = [];

sizeOfMessage = size(SentMessage);

for k = 1: sizeOfMessage(1)
    errorVector  = rand (1, sizeOfMessage(2)) < Pflip;
    tempOutputMatrix = [tempOutputMatrix; mod(errorVector + SentMessage(k,:), 2)];
end

CorruptedMessage  = tempOutputMatrix;
end
