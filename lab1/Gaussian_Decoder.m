function Gaussian_Decoder(receivedMatrix)
    
    messageSize = size(receivedMatrix);
    erasure_count = 0;
    error_indices = []; 
    char_matrix = [ 'F' 'G' 'H']; 
    
    for i = 1: messageSize(2) 
        % Check if we have < 3 erasures. Otherwise code is not decodeable
        if(erasure_count > 3) 
           fprintf('Cannot decode message. Message has more than three unknowns');  
           break;
        end
        if(abs(receivedMatrix(1,i)) == 0.5)
           
            erasure_count = erasure_count + 1; 
            receivedMatrix(1, i) = char_matrix(erasure_count); 
            error_indices = [error_indices; i]; 
       
        end
        % replace erasures with variables - e1,e2,e3
    end
    receivedMatrix 
    % we have to hardwire equations for parity for 6,3,3
  %  for k =1 : messageSize(2)
        syms F G H
        eqn1 =  receivedMatrix(1,1) + receivedMatrix(1,2)  - receivedMatrix(1,4) == 0 
        eqn2 =  receivedMatrix(1,1) + receivedMatrix(1,3)  - receivedMatrix(1,5) == 0
        eqn3 =  receivedMatrix(1,2) + receivedMatrix(1,3)  - receivedMatrix(1,6) == 0
  %  end
     [A,B] = equationsToMatrix([eqn1, eqn2, eqn3], [70 71 72]); 
     X = linsolve(A,B);                                    
     A
     B 
     X    
    % substitue and solve these equations from receivedMatrix
    
    
end