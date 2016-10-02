function codewordsDeferByDmin(codebook)
codebookSize = size(codebook);

differences = [];
differences3 = 0;
differences4 = 0;
% loop over all cws
for i = 1 : codebookSize(1)
    currentCw = codebook(i, :);
    for j = i : codebookSize(1)
        cwToCompare = codebook(j, :);
        differences = [differences; sum(mod(currentCw - cwToCompare, 2))];
        if (sum(mod(currentCw - cwToCompare, 2)) == 8) 
            differences3 = differences3 + 1;
        end
        
        if (sum(mod(currentCw - cwToCompare, 2)) == 4) 
            differences4 = differences4 + 1;
        end
        
    end
end
differences
differences4
differences3
end