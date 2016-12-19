function textCompressionDemo()

% reading text
fileID = fopen('demoTxt2.docx','r');
textFile = fscanf(fileID,'%s');

input = dec2bin(textFile);
input = input-'0';

input = reshape(input, 1, []);

% % computing probs and Hx
% p0 = 0;
% for i = 1 : length(input)
%     if (input(i) == 0)
%         p0 = p0 + 1;
%     end
% end
% 
% p0 = p0/length(input);
% p1 = 1 - p0;
% 
% % Markov computations
% ProbZeroAtOne = 1 - p1;
% ProbOneAtZero = 1 - p0;
% 
% pieZero = ProbZeroAtOne / (ProbZeroAtOne + ProbOneAtZero);
% pieOne = 1 - pieZero;
% Hx = pieZero * (p0 * log2(1/p0) + ProbOneAtZero * log2(1/ProbOneAtZero)) + pieOne * (p1 * log2(1/p1) + ProbZeroAtOne * log2(1/ProbZeroAtOne));
% 
% % for iid
% %Hx = p0*log2(1/p0) + p1*log2(1/p1);
% % W is the window size according to formula provided by Proff
% w = n^2*(2^(n*Hx));
% w3 = 0;
% rem =(3 - mod(ceil(2^(n*Hx)), n)) + ceil( 2^(n*Hx));
% if (mod(w,n) == 0)
%     w3 = w;
% else
%     w3 = n^2 * rem;
% end

length(input)
% encoding v1
[encoded1, ~] = LempelZivEncoder1(input, 14, 28);
compressionRatio1 = length(encoded1)/length(input)

% encoding v2
[encoded2, ~] = LempelZivEncoder2(input, 42, 400);
compressionRatio2 = length(encoded2)/length(input)

% v3
[encoded3, ~] = LempelZivEncoder3(input, 42, 400);
compressionRatio3 = length(encoded3)/length(input)
end