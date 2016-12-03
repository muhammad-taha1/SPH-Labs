function LempelZivTest()

% only constraint here is that the input length should be divisible by n
input = rand(1,100-1) < 0.4;%[0 1 0 0 0 0 0 0 1 1 1 0 1 0 1 0 1 0 0 1 0 0 0 0];
n = 3;

[encoded, dictionary] = LempelZivEncoder1(input, n);
decoded = LempelZivDecoder1(encoded, dictionary, n);

if (input ~= decoded)
    fprintf('fix me!');
end
end