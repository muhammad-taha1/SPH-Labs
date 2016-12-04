%% Decimal to Binary Conversion 
% This method is different than dec2bin in fact that it parses each bit in
% a vector of double instead of characters, making it easier to concatenate
% Inputs are the integer value to be converted and number of bits it's represented in 
function binary = decimalToBinary(integer, bits)

%Binary output vector in double format.  
binary = []; 
%% Number can be represented by given number of bits. 
if (integer > (2^bits-1)) 
    % add an exit statement. 
end 
%% Converting the number into binary 
while (integer ~= 0) 
    binary = [binary, mod(integer,2)]; 
    integer = floor(integer/2); 
end
%% Padding zeros
% When a number is represented by less number than input bits the output is
% padded with zeros. For example, decimalToBinary(7,2) will be 111 instead
% 0111, so this adds the zero. 
if(length(binary) ~= bits)
    for i = 1: bits - length(binary)
        binary = [binary, 0];
    end
end
%% Flip it to have in correct order. 
%binary = fliplr(binary); 
end