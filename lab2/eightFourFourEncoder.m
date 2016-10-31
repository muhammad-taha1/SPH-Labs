function codedMessage = eightFourFourEncoder(messageVector)
codeword =[]; 
codeword  = [codeword, messageVector];

p1 = mod(messageVector(1) + messageVector(2) + messageVector(3),2);
p2 = mod(messageVector(1) + messageVector(2) + messageVector(4),2);
p3 = mod(messageVector(1) + messageVector(3) + messageVector(4),2);
p4 = mod(messageVector(2) + messageVector(3) + messageVector(4),2);

codeword  = [codeword, p1 p2 p3 p4];
codedMessage = codeword; 
end 
