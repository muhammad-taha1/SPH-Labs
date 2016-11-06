function getExampleForQs5()

while (true)
    A = randi([0, 1], 4, 4);
    B = randi([0, 1], 4, 1);
    
    if (det(A) ~= 0)
        % singular matrix
        realX = linsolve(A, B);
        binX = mod(inv(A)*B, 2);
        
        realSolutionValid = true;
        for i = 1 : length(realX)
            if (~(realX(i) == 0 || realX(i) == 1))
                % real solution is not in terms of 0 and 1
                realSolutionValid = false;
                break;
            end
        end
        
        if (realSolutionValid)
            if (realX ~= binX)
                A
                B
                fprintf('Found Solution!!!!!');
                break;
            end
        end
    end
end
end