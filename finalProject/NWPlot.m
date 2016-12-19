function NWPlot()

% n and w are of same length
w = [20 40 60 80 100 120 140 160];
n = [2, 5, 10, 20, 25, 50, 80, 100];

comp1ToPlot = [];
comp2ToPlot = [];
comp3ToPlot = [];


for  i = 2 :2: 100
    comp1 = [];
    comp2 = [];
    comp3 = [];
    for j = 2 :2: 500
        
        input = rand(1, j*i*10^3) > 0.95;
        
        [encoded1, ~] = LempelZivEncoder1(input, i, j);
        [encoded2, ~] = LempelZivEncoder2(input, i, j);
        [encoded3, ~] = LempelZivEncoder3(input, i, j);
        
        comp1 =  [comp1 length(encoded1)/length(input)];
        comp2 =  [comp2 length(encoded2)/length(input)];
        comp3 =  [comp3 length(encoded3)/length(input)];
        
    end
    comp1ToPlot = [comp1ToPlot; comp1];
    comp2ToPlot = [comp2ToPlot; comp2];
    comp3ToPlot = [comp3ToPlot; comp3];
    
    
    
end
%stem(n, comp1);

figure
stem3(n,w,comp1ToPlot);

figure
stem3(n,w,comp2ToPlot);

figure
stem3(n,w,comp3ToPlot);
end