function LempelZivTest_n()
n = [2, 5, 10, 50, 100];
Pmatch1 = [];
Pmatch2 = [];
Pmatch3 = [];
avgPmatch1 = []; 
avgPmatch2 = [];
avgPmatch3 = []; 

% only constraint here is that the input length should be divisible by n
for i= 1: length(n)
    inputSizes = [100000];
    for j = 1: 1
        input = rand(1, inputSizes) > 0.95;
%% compute prob for each symbol, for Hx calculation. Assume that the input
% only has two: symbols, 0 and 1.

p0 = 0;
p1 = 0;
for k = 1 : length(input)
    if (input(k) == 0)
        p0 = p0 + 1;
    else
        p1 = p1 + 1;
    end
end

p0 = p0/length(input);
p1 = p1/length(input);

% Hx formula taken from dp1 report
Hx = p0*log2(1/p0) + p1*log2(1/p1);

if ((p0 == 1) || (p1 == 0)) 
    Hx = 0; 
end 
% W is the window size according to formula provided by Proff
w = n(i)^2*(2^(n(i)*Hx));
w3 = 0; 
rem =(3 - mod(ceil(2^(n(i)*Hx)), n(i))) + ceil( 2^(n(i)*Hx));
if (mod(w,n(i)) == 0) 
   w3 = w; 
else
    w3 = n(i)^2 * rem;
end
% ceil this value, can't have a window size in decimals
%w = ceil(w);
%w = 9; 
[encoded1, P_match1] = LempelZivEncoder1(input, n(i), w);
decoded1 = LempelZivDecoder1(encoded1, n(i), w);

Pmatch1(j) = Pmatch_1; 

if (~isequal(input,decoded1))
    fprintf('fix me 1!');
end

[encoded2, P_match2] = LempelZivEncoder2(input, n(i), w);
decoded2 = LempelZivDecoder2(encoded2, n(i), w);

Pmatch2(j) = P_match2; 

if (~isequal(input,decoded2))
    fprintf('fix me 2!');
end

[encoded3, P_match3] = LempelZivEncoder3(input, n(i),w3);
decoded3 = LempelZivDecoder3(encoded3, n(i), w3);

Pmatch3(j) = P_match3; 

if (~isequal(input,decoded3))
    fprintf('fix me 3!');
end
    end
    avgPmatch1(i)= mean(Pmatch1); 
    avgPmatch2(i) = mean(Pmatch2);
    avgPmatch3(i) = mean(Pmatch3);
    fprintf('Done!');
end
%% Plots against sizes of n
figure
stem(n, avgPmatch1, 'filled');
hold
stem(n, avgPmatch2, 'filled', 'red');
stem(n, avgPmatch3, 'filled', 'green');
xlabel('Length of n block'); 
ylabel('Compression Efficiency'); 
end