function decoded = LempelZivDecoder1(encoded, n, w)
% decode based on ecoded results created by
% LempelZivEncoder1
decoded = [];
pointerVector = []; 
% pointer used for decoding
pointerIdx = 1;
% loop over encoded vector
while (pointerIdx < length(encoded))
    if (encoded(pointerIdx) == 0)
        % if the first bit is 0, then we know the next n bits are the
        % original data bits
        decoded = [decoded, encoded(pointerIdx+1:pointerIdx+n)];
        % in next iteration of the loop we should be looking 3 bits later
        pointerIdx = pointerIdx + n + 1;
    else
        % when the first bit of encoder is 1, the next bit is a pointer to
        % where that value can be retrieved from encoded stream. The encoded(pointerIdx+1)
        % value indicates where to go to fetch the n repeated bits
        pointerVector  = [pointerVector, encoded(pointerIdx+1:pointerIdx+ceil(log2(w/n)))];
        pointer = bi2de(pointerVector);
        % Bear in mind that the encoded string has 1 bit between each n
        % bits that could be matched. So we have to determine how many
        % blocks of n later our match exists. This is done by using pointer
        % times chunk sisze(n). 
        decoded = [decoded, decoded(pointer*n+1:pointer*n+n)];
        % increase pointerIdx by 2. One increment is to skip over the pointer,
        % the next increment to go to the new flag in encoded stream
        pointerIdx = pointerIdx + ceil(log2(w/n)) + 1;
        pointerVector = []; 
    end
end
end