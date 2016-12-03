function decoded = LempelZivDecoder1(encoded, dictionary, n)
% decode based on ecoded matrix and dictionary created by
% LempelZivEncoder1
decoded = [];
[rowSize, ~] = size(encoded);
% loop over encoded string
for i = 1 : rowSize
    if (encoded(i,1) == 0)
        % get value from dictionary
        decoded = [decoded, dictionary(encoded(i,2):encoded(i,2)+n-1)];
    else
        % when the first bit of encoder is 1, get it from the decoded
        % result itself
        decoded = [decoded, decoded(encoded(i,2):encoded(i,2)+n-1)];
    end
end
end