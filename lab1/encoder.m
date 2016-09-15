function encodedMatrix = encoder (n, k, dmin)
msg = [];
for i =1 : k
    % create random msg matrix
    msg_string = randi([0 1], 1, k);   
    msg = [msg; msg_string];
end

msg
% bitwise summation of msg
% paritySum = [];

% for i = 1 : k
%     pb = max(msg(:,i));
%     paritySum = [paritySum pb];
% end

parityMatrix = [];
for j = 1: k
    parity = msg(1,:);
    for s = 1: k
        % creating parity bits
        
        rowToSubs = k - s + 1; % j starts from 1, so add 1 to take last row into account
        if (s == rowToSubs)
            %dont add
        else
            parity = bitor(parity, msg(s,:));
            %add
        end
    
    end
    parityMatrix = [parityMatrix; parity];
    % append parity bits to msg matrix
end
parityMatrix
msg = [msg parityMatrix];
%g= [1 0 0, 0 1 0, 0 0 1]; 
% codeword = messages * g; 
%E = (-0.5* ( rand (1, length) < Pe); 
%encodedMatrix = 

finalMsg = msg

end