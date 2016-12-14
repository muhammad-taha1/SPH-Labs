function output = MarkovSource(size, probZeroAtZero, probOneAtOne)

output = [];
if (probZeroAtZero > probOneAtOne)
    output = [output, 0];
elseif (probZeroAtZero == probOneAtOne)
    output = [output, 0];
else
    output = [output, 1];
end
for i = 1 : size - 1
    % start with 0
    if (output(i) == 0)
        bit = rand(1,1)>probZeroAtZero;
    else
        bit = rand(1,1)>(1 - probOneAtOne);
    end
    output = [output, bit];
    
end
end