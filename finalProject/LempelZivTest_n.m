function LempelZivTest_n()
n = [2, 5, 10, 20, 25, 50, 80, 100];
compRatio1 = [];
compRatio2 = [];
compRatio3 = [];
avgCompRatio1 = []; 
avgCompRatio2 = [];
avgCompRatio3 = []; 
iter = 50; 
% only constraint here is that the input length should be divisible by n
for i= 1: length(n)
    inputSizes = [10000];
    for j = 1: iter
        input = rand(1, inputSizes) > 0.99;
%% compute prob for each symbol, for Hx calculation. Assume that the input
% only has two: symbols, 0 and 1.

p0 = 0.90;
p1 = 1 - p0;

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

compRatio1(j) = length(encoded1) / length(input); 

if (~isequal(input,decoded1))
    fprintf('fix me 1!');
end

[encoded2, P_match2] = LempelZivEncoder2(input, n(i), w);
decoded2 = LempelZivDecoder2(encoded2, n(i), w);

compRatio2(j) = length(encoded2) / length(input); 

if (~isequal(input,decoded2))
    fprintf('fix me 2!');
end

[encoded3, P_match3] = LempelZivEncoder3(input, n(i),w3);
decoded3 = LempelZivDecoder3(encoded3, n(i), w3);

compRatio3(j) = length(encoded3) / length(input); 

if (~isequal(input,decoded3))
    fprintf('fix me 3!');
end
    end
    avgCompRatio1(i)= mean(compRatio1); 
    avgCompRatio2(i) = mean(compRatio2);
    avgCompRatio3(i) = mean(compRatio3);
    fprintf('Done!');
end
%% Plots against sizes of n
figure
stem(n, avgCompRatio1, 'x');
hold
stem(n, avgCompRatio2, 'o', 'red');
stem(n, avgCompRatio3, '*', 'green');
xlabel('Length of n block'); 
ylabel('Compression Efficiency'); 
end