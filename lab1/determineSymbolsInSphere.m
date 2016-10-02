function determineSymbolsInSphere(n, r)
diffSymbols = 0;
baseCw = zeros(1,n);
allSymbols = [];
allSymbols = [allSymbols; baseCw];

for num = 1 : (2^n - 1)
    allSymbols = [allSymbols; de2bi(num, n, 'left-msb')];
end

for k = 0 : r
    for i = 1 : (2^n - 1)
        if (sum(mod((allSymbols(i, :) - baseCw), 2)) == k)
            diffSymbols = diffSymbols + 1;
        end
    end
end

diffSymbols
end