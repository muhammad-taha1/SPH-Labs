function X = binSolve(A, B)
% use gaussian elimination to solve the equations
% returns the solutions in x, a defines the coefficients and b the
% RHS constants
% Solves only 4 equations with 4 unknowns

% initialize for recursion
X = B;
% Check and arrange matrix A according to row-echelon
row_echelon_A = A;
row_echelon_B = B;
% let r1 be the rowCount for row_echelon_A
r1 = 0;
% r and c are row and column count of A respectively
[r, c] = size(A);

% exit if we have a zero row or if two rows are the same (which would give
% a zero row eventually)
for i = 1 : r
    if (sum(A(i, :)) == 0)
        X = [inf; inf; inf; inf];
        B = [inf; inf; inf; inf];
        return;
    end
    
    for row2 = 1 : r
        if (all(A(i, :) == A(row2, :)) && (i ~= row2))
            X = [inf; inf; inf; inf];
            B = [inf; inf; inf; inf];
            return;
        end
    end
end
% set solutionFound to true to return final output and exit recursion only 
% when each row in A has only one 1
solutionFound = true;
for row = 1 : r
    if (sum(A(row, :)) ~= 1)
        solutionFound = false;
    end
end

if (solutionFound)
    % when solutionFound is true, A resembles an identity matrix (except
    % its not arranged). So we arrange X according to identity matrix which
    % will be the final output from the function.
    for row = 1 : r
        for col = 1 : c
            if (A(row, col) == 1)
                X(col, 1) = B(row, 1);
            end
        end
    end
    % set B as X to avoid recursion issues and return
    B = X;
    return;
end

% Since we assume that the inputs A and B will only have 0s and 1s, for
% row-echelon, all that needs to be done is to arrange the matrix such that
% A matrix is triangular

% repeat process until all rows from A have been added to row_echelon_A,
% thereby saying that repeat while r1 ~= r
% while (r1 ~= r)
%     [r1, ~] = size(row_echelon_A);
%     % loop over all rows in A
%     for row = 1 : r
%         % uniqueRowFound is true only when we find a row that satisfies the
%         % requirements for triangular matrix and when that row from A is
%         % not in row_echelon_A
%         uniqueRowFound = false;
%         for col = 1 : c
%             % Row echelon condition: we need a '1' diagonal. So we need to
%             % append row_echelon_A when we have a row where the r1+1 column
%             % is 1. So 1st row in row_echelon_A should have the very first
%             % column as 1, 2nd row should have the 2nd column as 1 and so
%             % on
%             if ((r1 + 1) == col && A(row, col) == 1)
%                 uniqueRowFound = true;
%                 % Check if the row already exists in A. In that case we do
%                 % not append. This check is needed because the if condition
%                 % above may be true for rows having multiple 1s
%                 for row_ech = 1 : r1
%                     if (row_echelon_A(row_ech, :) == A(row, :))
%                         uniqueRowFound = false;
%                         break;
%                     end
%                 end
%                 % Append only when uniqueRowFound is true. Adjust
%                 % row_echelon_B according to row_echelon_A
%                 if (uniqueRowFound)
%                     row_echelon_A = [row_echelon_A; A(row,:)];
%                     row_echelon_B = [row_echelon_B; B(row, :)];
%                 end
%             end
%         end
%         if (uniqueRowFound)
%             break;
%         end
%     end
% end


% Now perform Gaussian elimination
% strategy: reduce number of ones in some rows
% only do one operation per recursion to avoid complexity
operationDone = false;
for row = 1 : r
    if (operationDone)
        break;
    end
    for row2 = 1 : r
        numberOfOnesInRow = sum(row_echelon_A(row , :));
        % Check if numberOfOnesInRow can be reduced by row addition
        if (sum(mod(row_echelon_A(row , :) + row_echelon_A(row2 , :), 2)) < numberOfOnesInRow && row ~= row2)
            % Add row2 to row
            row_echelon_A(row , :) = mod(row_echelon_A(row , :) + row_echelon_A(row2 , :), 2);
            row_echelon_B(row , :) = mod(row_echelon_B(row , :) + row_echelon_B(row2 , :), 2);
            % break and move on to next row
            operationDone = true;
            break;
        end
    end
end

% Recurse the function until we reach the identity matrix for row_echelon_A
% temp output
X = binSolve(row_echelon_A, row_echelon_B);
end