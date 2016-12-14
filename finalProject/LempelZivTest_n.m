function LempelZivTest_n()
%n = [2, 5, 10, 20, 25, 50, 80, 100];
n = [16, 128];
compRatio1 = [];
compRatio2 = [];
compRatio3 = [];
avgCompRatio1 = [];
avgCompRatio2 = [];
avgCompRatio3 = [];
doMarkov = 0;

p0 = 0.99;
p1 = 1 - p0;
p1AtOne = 0.8;
% only constraint here is that the input length should be divisible by n
for i= 1: length(n)
    inputSizes = [10^2*1024];
    for j = 1: 1
        if (doMarkov)
            input = MarkovSource(inputSizes, p0, p1AtOne);%
        else
            input = rand(1, inputSizes) > p0;
        end
        %% compute prob for each symbol, for Hx calculation. Assume that the input
        % only has two: symbols, 0 and 1.
        
        % Hx formula taken from dp1 report
        if (doMarkov)
            ProbZeroAtOne = 1 - p1AtOne;
            ProbOneAtZero = 1 - p0;
            
            pieZero = ProbZeroAtOne / (ProbZeroAtOne + ProbOneAtZero);
            pieOne = 1 - pieZero;
            Hx = pieZero * (p0 * log2(1/p0) + ProbOneAtZero * log2(1/ProbOneAtZero)) + pieOne * (p1AtOne * log2(1/p1AtOne) + ProbZeroAtOne * log2(1/ProbZeroAtOne));
        else
            Hx = p0*log2(1/p0) + p1*log2(1/p1);
        end
        
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
       w = 512; 
       w3= 512;
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
    avgCompRatio1(i) = mean(compRatio1);
    avgCompRatio2(i) = mean(compRatio2);
    avgCompRatio3(i) = mean(compRatio3);
end
figure
stem(n, avgCompRatio1, 'x');
hold on
stem(n, avgCompRatio2, '*', 'red');
hold on
stem(n, avgCompRatio3, 'o', 'green');
xlabel('Length of n block');
ylabel('Compression Efficiency');
legend('LZ encoder 1', 'LZ encoder 2', 'LZ encoder 3');
Title('Compression Ratio'); 
end