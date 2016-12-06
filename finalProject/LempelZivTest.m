function LempelZivTest()


% only constraint here is that the input length should be divisible by n
input = [0 1 0 0 0 0 0 0 1 1 1 0 1 0 1 0 1 0 1 1 1 0 1 0 0 0 0 1 1 0];%rand(1,100-1) < 0.4;
n = 3;

% compute prob for each symbol, for Hx calculation. Assume that the input
% only has two symbols, 0 and 1.

p0 = 0;
p1 = 0;
for i = 1 : length(input)
    if (input(i) == 0)
        p0 = p0 + 1;
    else
        p1 = p1 + 1;
    end
end

p0 = p0/length(input);
p1 = p1/length(input);

% Hx formula taken from dp1 report
Hx = p0*log2(1/p0) + p1*log2(1/p1);

% W is the window size according to formula provided by Proff
w = n^2*(2^(n*Hx));
% ceil this value, can't have a window size in decimals
%w = ceil(w);

encoded1 = LempelZivEncoder1(input, n, w);
decoded1 = LempelZivDecoder1(encoded1, n, w);

if (~isequal(input,decoded1))
    fprintf('fix me!');
end

encoded2 = LempelZivEncoder2(input, n, w);
decoded2 = LempelZivDecoder2(encoded2, n, w);

if (~isequal(input,decoded2))
    fprintf('fix me!');
end
end