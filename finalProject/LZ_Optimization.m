function LZ_Optimization 

iter = 10; %number of iterations 
P0 = 0.99; 

input = []; 
compRatio1 = [];
compRatio2 = [];
compRatio3 = [];
avgCompRatio1 = []; 
avgCompRatio2 = [];
avgCompRatio3 = []; 
Pmatch1 = [];
Pmatch2 = [];
Pmatch3 = [];
avgPmatch1 = [];
avgPmatch2 = [];
avgPmatch3 = [];

j= 1; 
k= 1; 

for n = 3:200
    for w = 2*n:n:20*n 
        for i = 1: iter 
            inputSize = 10^4; 
            if (mod(inputSize,n) == 0)
                input = rand(1, inputSize) > P0;
            else
                inputSize = inputSize + n- mod(inputSize, n);
                input = rand(1, inputSize) > P0;
            end 
            
            [encoded1, P_match1] = LempelZivEncoder1(input, n, w);
            decoded1 = LempelZivDecoder1(encoded1, n, w);

            compRatio1(i) = length(encoded1) / length(input); 
            Pmatch1(i) = P_match1;
            
            if (~isequal(input,decoded1))
                fprintf('fix me 1!');
            end

            [encoded2, P_match2] = LempelZivEncoder2(input, n, w);
            decoded2 = LempelZivDecoder2(encoded2, n, w);

            compRatio2(i) = length(encoded2) / length(input); 
            Pmatch2(i) = P_match2;
            
            if (~isequal(input,decoded2))
                fprintf('fix me 2!');
            end

            [encoded3, P_match3] = LempelZivEncoder3(input, n,w);
            decoded3 = LempelZivDecoder3(encoded3, n, w);

            compRatio3(i) = length(encoded3) / length(input); 
            Pmatch3(i) = P_match3;
            
            if (~isequal(input,decoded3))
                fprintf('fix me 3!');
            end
        end 
        avgCompRatio1(k, j)= mean(compRatio1); 
        avgCompRatio2(k, j) = mean(compRatio2);
        avgCompRatio3(k, j) = mean(compRatio3);
        avgPmatch1(k, j) = mean(Pmatch1);
        avgPmatch2(k, j) = mean(Pmatch2);
        avgPmatch3(k, j) = mean(Pmatch3);
        window(k, j) = w;
        matches(k,j) = n;
        j = j +1;
    end 
    j =1; 
    k = k +1; 
end 

figure
stem3(matches, window, avgCompRatio1);
xlabel('Length of matches n');
ylabel('Length of window w');
zlabel('Compression Ratio');
title('Optimization Plot of Compression Ratio for LZ Encoder V1 with i.i.d Source of P0 = 0.99'); 
[x1, y1] = find(avgCompRatio1==min(avgCompRatio1(:)));
minW1 = window(x1,y1); 
minN1 = matches(x1,y1);
strmin = ['Minimum compression = ',num2str(min(min(avgCompRatio1))),  ' at w = ', num2str(minW1), ' and n = ', num2str(minN1), ' and Pmatch = ', num2str(avgPmatch1(x1, y1))];
text(minN1,minW1,min(min(avgCompRatio1)), strmin,'HorizontalAlignment','left');

figure
stem3(matches, window, avgCompRatio2);
xlabel('Length of matches n');
ylabel('Length of window w');
zlabel('Compression Ratio');
title('Optimization Plot of Compression Ratio for LZ Encoder V2 with i.i.d Source of P0 = 0.99'); 
[x2, y2] = find(avgCompRatio2==min(avgCompRatio2(:)));
minW2 = window(x2,y2); 
minN2 = matches(x2,y2); 
strmin = ['Minimum compression = ',num2str(min(min(avgCompRatio2))), ' at w = ', num2str(minW2), ' and n = ', num2str(minN2), ' and Pmatch = ', num2str(avgPmatch2(x2, y2))];
text(minN2,minW2,min(min(avgCompRatio2)), strmin,'HorizontalAlignment','left');

figure
stem3(matches, window, avgCompRatio3);
xlabel('Length of matches n');
ylabel('Length of window w');
zlabel('Compression Ratio');
title('Optimization Plot of Compression Ratio for LZ Encoder V3 with i.i.d Source of P0 = 0.99'); 
[x3, y3] = find(avgCompRatio3==min(avgCompRatio3(:)));
minW3 = window(x3,y3); 
minN3 = matches(x3,y3);
strmin = ['Minimum compression =',num2str(min(min(avgCompRatio3))), ' at w = ', num2str(minW3), ' and n = ', num2str(minN3), ' and Pmatch = ', num2str(avgPmatch3(x3, y3))];
text(minN3,minW3,min(min(avgCompRatio3)), strmin,'HorizontalAlignment','left');

figure
stem3(matches, window, avgPmatch1);
xlabel('Length of matches n');
ylabel('Length of window w');
zlabel('Pmatch');
title('Optimization Plot of Pmatch for Lempel-Ziv Encoder V1 with i.i.d Source of P0 = 0.99'); 
[x1, y1] = find(avgPmatch1==max(avgPmatch1(:)));
maxW1 = window(x1,y1); 
maxN1 = matches(x1,y1);
strmax = ['Maximum Pmatch = ',num2str(max(max(avgPmatch1))),  ' at w = ', num2str(maxW1), ' and n = ', num2str(maxN1)];
text(maxN1,maxW1,max(max(avgPmatch1)), strmax,'HorizontalAlignment','left');

figure
stem3(matches, window, avgPmatch2);
xlabel('Length of matches n');
ylabel('Length of window w');
zlabel('Pmatch');
title('Optimization Plot of Pmatch for Lempel-Ziv Encoder V2 with i.i.d Source of P0 = 0.99'); 
[x2, y2] = find(avgPmatch2==max(avgPmatch2(:)));
maxW2 = window(x2,y2); 
maxN2 = matches(x2,y2);
strmax = ['Maximum Pmatch = ',num2str(max(max(avgPmatch2))),  ' at w = ', num2str(maxW2), ' and n = ', num2str(maxN2)];
text(maxN2, maxW2,max(max(avgPmatch2)), strmax,'HorizontalAlignment','left');

figure
stem3(matches, window, avgPmatch3);
xlabel('Length of matches n');
ylabel('Length of window w');
zlabel('Pmatch');
title('Optimization Plot of Pmatch for Lempel-Ziv Encoder V3 with i.i.d Source of P0 = 0.99'); 
[x3, y3] = find(avgPmatch1==max(avgPmatch1(:)));
maxW3 = window(x3,y3); 
maxN3 = matches(x3,y3);
strmax = ['Maximum Pmatch = ',num2str(max(max(avgPmatch3))),  ' at w = ', num2str(maxW3), ' and n = ', num2str(maxN3)];
text(maxN3,maxW3,max(max(avgPmatch3)), strmax,'HorizontalAlignment','left');

end 