function SyndromeTesterDemo(pFlip)
msg = [];
for i = 1 : 3
    % create random msg matrix
    msg_string = randi([0 1], 1, 3);
    msg = [msg; msg_string];
end
encodedMatrix = encoder(6,3,3, msg)
corruptedMatrix = Pflip_Error_Channel(encodedMatrix, pFlip)
decodedAns = SyndroneDecoder(corruptedMatrix)


end