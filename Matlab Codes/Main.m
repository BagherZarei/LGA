clc;

networkFileFullName = '..\Test Networks\Real World\01 - Karate.net';
tcomFileFullName = '..\Test Networks\Real World\01 - Karate.tcom'; %if it does not exist, leave it blank

algorithmParameters.populationSize = 100;
algorithmParameters.isImproveInitialPopulation = true;
algorithmParameters.percentageOfChromosomesToImprove = 20;
algorithmParameters.percentageOfGenesToImprove = 10;
algorithmParameters.crossoverRate = 0.8;
algorithmParameters.mutationRate = 0.2;
algorithmParameters.learningAlgorithm = 'Linear learning';
algorithmParameters.rewardParameter = 0.1;
algorithmParameters.penaltyParameter = 0.1;
algorithmParameters.maxGenerations = 100;
algorithmParameters.maxStallGenerations = 10;
algorithmParameters.functionTolerance = 0.001;

fprintf('Started...\n');
fprintf('In progress...\n');
tic;
[foundSolution, convergedGeneration] = LGA_Algorithm(networkFileFullName, algorithmParameters);
executionTime = toc;
fprintf('Finished...\n');

if (~isempty(tcomFileFullName))
    [~, adjacencyMatrix] = CreateNetworkGraphFromNetworkEdgesFile(networkFileFullName);
    trueSolution.com = ReadCommunityStructureFromFile(tcomFileFullName);
    trueSolution.mod = Modularity(trueSolution.com, adjacencyMatrix);
    foundSolution.NMI = NormalizedMutualInformation(trueSolution.com, foundSolution.com);
end

if (~isempty(tcomFileFullName))
    fprintf('Found Modularity: %6.4f\n', foundSolution.mod);
    fprintf('True Modularity: %6.4f\n', trueSolution.mod);
    fprintf('Normalized Mutual Information: %6.4f\n', foundSolution.NMI);
    fprintf('Converged Generation: %d\n', convergedGeneration);
    fprintf('Execution Time: %6.4f\n', executionTime);
else
    fprintf('Found Modularity: %6.4f\n', foundSolution.mod);
    fprintf('Converged Generation: %d\n', convergedGeneration);
    fprintf('Execution Time: %6.4f\n', executionTime);
end