function decodedMatrix = Gaussian_Decoder(receivedMatrix)

messageSize = size(receivedMatrix);

for row = 1 : messageSize(1)
    % Initialize erasure_count and error_indices for each row
    erasure_count = 0;
    error_indices = [];
    
    % Matrix with symbolic representation of the receivedMatrix. Will be used
    % to solve linear equations
    sym_matrix = sym(receivedMatrix);
    % All possible erasure values (e1, e2, e3) per row
    e = sym('e',[1 3]);
    
    for i = 1 : messageSize(2)
        % Check if we have < 3 erasures. Otherwise code is not decodeable
        if(erasure_count > 3)
            fprintf('Cannot decode message. Message has more than three unknowns');
            return;
        end
        
        if(abs(receivedMatrix(row, i)) == 0.5)
            % Replace sym_matrix with erasures values from e. This is then used
            % as equation unknowns when solving linear equations
            % erasure_count is incremented as well
            erasure_count = erasure_count + 1;
            error_indices = [error_indices; i];
            sym_matrix(row, i) = e(erasure_count);
        end
    end
    
    % hardwired equations of parity for 6,3,3
    eqn1 =  sym_matrix(row, 1) + sym_matrix(row, 2) - sym_matrix(row, 4) == 0;
    eqn2 =  sym_matrix(row, 1) + sym_matrix(row, 3) - sym_matrix(row, 5) == 0;
    eqn3 =  sym_matrix(row, 2) + sym_matrix(row, 3) - sym_matrix(row, 6) == 0;
    [A,B] = equationsToMatrix([eqn1, eqn2, eqn3], e(1:erasure_count));
    
    % Number of equations required to solve are equivalent to number of
    % unknowns. X contains all the solutions for this row
    X = linsolve(A(1 : erasure_count, :), B(1 : erasure_count, :));
    
    % Convert solutions to binary
    for i = 1 : size(X)
        X(i) = mod(abs(X(i)), 2);
    end
    
    % replace erasures with the solutions in receivedMatrix, at the locations
    % specified by error_indices
    for i = 1 : size(error_indices)
        receivedMatrix(row, error_indices(i)) = X(i);
    end
end

decodedMatrix = receivedMatrix;
end