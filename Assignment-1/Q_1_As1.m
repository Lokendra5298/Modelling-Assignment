numExperiments = 50;
resultsTable = table('Size', [numExperiments, 4], 'VariableTypes', {'double', 'double', 'double', 'double'}, ...
    'VariableNames', {'Experiment', 'CherriesPacked', 'MinCherriesPacked', 'MaxCherriesPacked'});

% Loop through the experiments
for experiment = 1:numExperiments
    % Generate random values for r, R, and h within the specified constraints
    R = rand() * 5 + 5; % Random value between 5 and 10 for the can's radius R
    r = rand() * (R - 0.1); % Ensure r < R
    h = 2 * r + rand() * (10 - 2 * r); % Random value between 2*r and 10
    
    % Calculate the volume of the cylindrical can
    canVolume = pi * R^2 * h;
    
    % Calculate the number of cherries that can be packed in the can
    cherryVolume = (4/3) * pi * r^3; % Assuming cherries are spherical
    cherriesPacked = floor(0.69*canVolume / cherryVolume);
    
    % Calculate the minimum and maximum cherries packed using the given formulas
    minCherriesPacked = floor(R^2 * h / (2 * r^3));
    maxCherriesPacked = floor(0.74 * canVolume / cherryVolume);
    
    % Store the results in the table
    resultsTable(experiment, :) = {experiment, cherriesPacked, minCherriesPacked, maxCherriesPacked};
end

% Display only the desired columns
disp(resultsTable(:, {'Experiment', 'CherriesPacked', 'MinCherriesPacked', 'MaxCherriesPacked'}));
