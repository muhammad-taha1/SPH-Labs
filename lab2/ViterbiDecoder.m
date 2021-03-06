function decodedOutput = ViterbiDecoder(receivedRow)
%clear all 
clc
%% Knowns for the (8,4,4) code 
codebookEdges = [ 0 0 ; 1 1; 0 1; 1 0];
levelEdgeDistance = []; 
numberOfPaths = [ 1 1 1 1; 2 2 2 2; 2 2 2 2; 1 1 1 1] ;

%% Calculate the distance at edges 
% The distances are stored in a 4 by 4 vector where the rows are stages of
% trellis and columns are the edges
    for k = 1 : 4 % number of stages in trellis for (8,4,4) Hamming Code 
        for n = 1 : 4 % number of edge calcs in each level 
            if( (k == 2) | (k == 3))
                levelEdgeDistance(k,n) = (receivedRow(k+1)  - codebookEdges(n, 1))^2 +(receivedRow(k+3)  - codebookEdges(n, 2))^2;
            elseif (k ==4)
                levelEdgeDistance(k,n) = (receivedRow(k+3)  - codebookEdges(n, 1))^2 +(receivedRow(k+4)  - codebookEdges(n, 2))^2; 
            else
                levelEdgeDistance(k,n) = (receivedRow(k)  - codebookEdges(n, 1))^2 +(receivedRow(k+1)  - codebookEdges(n, 2))^2;
            end
        end
    end
    
%% Store edges distance in vectors for each stage
% Each stage contains a varying number of edges, thus a vector for each
% stage stores distance at each edge 
    StageOneMinDist   = []; 
    StageTwoMinDist   = []; 
    StageThreeMinDist = []; 
    StageFourMinDist  = []; 
    
    for l = 1 : 4 
        StageOneMinDist = [StageOneMinDist ,levelEdgeDistance(1,l)];
        if((l == 1) | (l == 2))
            StageTwoMinDist = [StageTwoMinDist, levelEdgeDistance(2, 1)];
            StageThreeMinDist = [StageThreeMinDist, levelEdgeDistance(3,1)];
            StageTwoMinDist = [StageTwoMinDist, levelEdgeDistance(2, 2)];
            StageThreeMinDist = [StageThreeMinDist, levelEdgeDistance(3,2)];
        else 
            StageTwoMinDist = [StageTwoMinDist, levelEdgeDistance(2, 3)];
            StageThreeMinDist = [StageThreeMinDist, levelEdgeDistance(3,3)];
            StageTwoMinDist = [StageTwoMinDist, levelEdgeDistance(2, 4)];
            StageThreeMinDist = [StageThreeMinDist, levelEdgeDistance(3,4)];
        
        end
            StageFourMinDist = [StageFourMinDist, levelEdgeDistance(4, l)];
    end
shortestPathsVect = [];
minDistSum = [];
shortestPathCodeword = []; 

%% Search Step
% ADD-STORE-COMPARE at each state/stage of trellis taking the minimum sum
% and storing it in  a vector at each stage for each state
for stage = 1 : 4
    for state = 1 : 4
        if (numberOfPaths(stage,state) == 1)
            if(stage == 1)
                shortestPathsVect(stage,state) =  StageOneMinDist(state);
                shortestPathCodeword(stage, state) = numberOfPaths(stage,state);
            else
                if (shortestPathCodeword(2 , state) == shortestPathCodeword(3 , state))
                    shortestPathsVect(stage,state) =  StageFourMinDist(state) + shortestPathsVect(stage - 1,state); 
                    shortestPathCodeword(stage, state) = numberOfPaths(stage,state);
                else
                    if(state == 1 | state == 3) 
                        shortestPathsVect(stage,state) =  StageFourMinDist(state + 1) + shortestPathsVect(stage - 1,state); 
                    else
                        shortestPathsVect(stage,state) =  StageFourMinDist(state - 1) + shortestPathsVect(stage - 1,state); 
                    end
                    shortestPathCodeword(stage, state) = numberOfPaths(stage,state);    
                end
            end
        end
        if (numberOfPaths(stage,state) == 2) 
            if(stage == 2)  
                    minDistSum = [StageTwoMinDist(2*state - 1) + shortestPathsVect(stage - 1,state); StageTwoMinDist(2*state) + shortestPathsVect(stage - 1,state)]; 
                    for s =1 : size(minIndex)
                        shortestPathsVect(stage,state) =  minDistSum(minIndex(s)); 
                        shortestPathCodeword(stage,state) = minIndex(s); 
                    end
            else
                    minDistSum = [StageThreeMinDist(2*state - 1) + shortestPathsVect(stage - 1,state); StageThreeMinDist(2*state) + shortestPathsVect(stage - 1,state)];
                    minIndex = find(minDistSum == min(minDistSum(:)));
                    for s =1 : size(minIndex)
                        shortestPathsVect(stage,state) =  minDistSum(minIndex(s)); 
                        shortestPathCodeword(stage,state) = minIndex(s); 
                    end
            end
        end
    end
end
%% Find min sum of the four states 
% Take the path of that state

shortestPaths = shortestPathsVect(4, :);
CodewordPath = [];

minPath = find(shortestPaths == min(shortestPaths(:)));

for h = 1: size(minPath)
    CodewordPath = [CodewordPath; shortestPathCodeword(:,minPath(h))];
end

%% Retrieve codeword for path
% Using path vector, retrieve codeword that matches this path by  matching
% the edges with the symbols. 
%Retrieves symbols for 1st, 2nd, 3rd, and 4th stages

codeword =[]; 
for j = 1: 4
    if((minPath == 1) | (minPath == 2))  
        if((CodewordPath(j) == 1) && (j == 2 | j == 3))
            codeword(j + 1) = 0;
            codeword(j + 3) = 0;
        elseif(((CodewordPath(j) == 2) && (j == 2 | j == 3)))
            codeword(j + 1) = 1;
            codeword(j + 3) = 1;
        elseif(((minPath == 1) && (j == 4) && (CodewordPath(2) == CodewordPath(3)))| ((minPath == 2) && (j == 4) && (CodewordPath(2) ~= CodewordPath(3))) | ((minPath == 1) && (j == 1)))
            codeword(2*j - 1) = 0;
            codeword(2*j) = 0;
        else
            codeword(2*j - 1) = 1;
            codeword(2*j) = 1;
        end
    else
        
        if(((minPath == 3) && (j == 4) && (CodewordPath(2) == CodewordPath(3)))| ((minPath == 4) && (j == 4) && (CodewordPath(2) ~= CodewordPath(3)))|((minPath == 3) && (j == 1)))
            codeword(2*j - 1) = 0;
            codeword(2*j) = 1;
        elseif(((minPath == 4) && (j == 4)&& (CodewordPath(2) == CodewordPath(3)))| ((minPath == 3) && (j == 4) && (CodewordPath(2) ~= CodewordPath(3))) | ((minPath == 4) && (j == 1)))
            codeword(2*j - 1) = 1;
            codeword(2*j) = 0;
        elseif((CodewordPath(j) == 1) && (j == 2 | j == 3))
            codeword(j + 1) = 0;
            codeword(j + 3) = 1; 
        else
            codeword(j + 1) = 1;
            codeword(j + 3) = 0; 
        end
    end
end
%% Output codeword
decodedOutput = codeword;
end