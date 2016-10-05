function decodedMatrix = Gaussian_Decoder(receivedMatrix)
messageSize = size(receivedMatrix);

for row = 1 : messageSize(1)
    % Initialize erasure_count and error_indices for each row
    erasure_count = 0;
    error_indices = [];
    solveCurrentRow = true;
    
    % These 3 variables would tell us which equations should be linearly
    % solved after the equations are formed
    solveEqn1 = false;
    solveEqn2 = false;
    solveEqn3 = false;
    
    % Matrix with symbolic representation of the receivedMatrix. Will be 
    % used to solve linear equations
    sym_matrix = sym(receivedMatrix);
    % All possible erasure values (e1, e2, e3) per row
    e = sym('e',[1 3]);
    
    for i = 1 : messageSize(2)
        % Check if we have < 3 erasures. Otherwise code is not decodeable
        % Also check if we have 3 erasures already and another one shows
        % up. The code is also undecodeable now
        if(erasure_count > 3 || (erasure_count == 3 ...
                && abs(receivedMatrix(row, i)) == 0.5))
            % assign just to keep matlab happy
            decodedMatrix = receivedMatrix;
            solveCurrentRow = false;
        end
        
        if(abs(receivedMatrix(row, i)) == 0.5 && solveCurrentRow)
            % Replace sym_matrix with erasures values from e. This is then 
            % used as equation unknowns when solving linear equations
            % erasure_count is incremented as well
            erasure_count = erasure_count + 1;
            error_indices = [error_indices; i];
            sym_matrix(row, i) = e(erasure_count);
            
            % Determine which equations should be solved
            if (i == 1 || i == 2 || i == 4)
                solveEqn1 = true;
            end
            if (i == 1 || i == 3 || i == 5)
                solveEqn2 = true;
            end
            if (i == 2 || i == 3 || i == 6)
                solveEqn3 = true;
            end
        end
    end
    
    toSolveA = [];
    toSolveB = [];
    
    % hardwired equations of parity for 6,3,3
    eqn1 = sym_matrix(row, 1) + sym_matrix(row, 2) - sym_matrix(row, 4) == 0;
    eqn2 = sym_matrix(row, 1) + sym_matrix(row, 3) - sym_matrix(row, 5) == 0;
    eqn3 = sym_matrix(row, 2) + sym_matrix(row, 3) - sym_matrix(row, 6) == 0;
    [A, B] = equationsToMatrix([eqn1, eqn2, eqn3], e(1:erasure_count));
    % Number of equations required to solve are equivalent to number of
    % unknowns.
    
    % Append equations to solve from A and B into toSolveA and toSolveB
    if (solveEqn1)
        toSolveA = [toSolveA; A(1, :)];
        toSolveB = [toSolveB; B(1, :)];
    end
    if (solveEqn2)
        toSolveA = [toSolveA; A(2, :)];
        toSolveB = [toSolveB; B(2, :)];
    end
    if (solveEqn3)
        toSolveA = [toSolveA; A(3, :)];
        toSolveB = [toSolveB; B(3, :)];
    end
    
    % Sanity check to conclude that message cannot be decoded
    toSolveSize = size(toSolveA);
    if (erasure_count > toSolveSize(1))
        % assign just to keep matlab happy
        decodedMatrix = receivedMatrix;
        solveCurrentRow = false;
    end
    
    % X contains all the solutions for this row. We need to take
    % equations from 1 to erasure_count, in order to ensure unique
    % solutions for each unknown (this is to avoid the possibility of
    % having the same unknown show up on multiple rows. Solving them may
    % give different solutions to the same unknown, since linsolve is not
    % binary)
    
    if (solveCurrentRow)
        X = linsolve(toSolveA(1 : erasure_count, :),...
            toSolveB(1 : erasure_count, :));
        
        % Convert solutions to binary
        for i = 1 : size(X)
            X(i) = mod(abs(X(i)), 2);
        end
        
        % replace erasures with the solutions in receivedMatrix, at 
        % the locations specified by error_indices
        for i = 1 : size(error_indices)
            receivedMatrix(row, error_indices(i)) = X(i);
        end
    end
    
end


decodedMatrix = receivedMatrix;
end