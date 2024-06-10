% Number of samples
n = 100;

% Generate random values for r, R, and h following a normal distribution
r = abs(normrnd(5, 1, [1, n])); % r > 0
R = abs(normrnd(10, 2, [1, n])); % r < R
h = max(2*r, abs(normrnd(15, 3, [1, n]))); % h >= 2*r

% Create a dataset matrix
data = [r; R; h]';

% Split the dataset into train and test sets (e.g., 80% train, 20% test)
train_ratio = 0.8;
n_train = floor(n * train_ratio);
n_test = n - n_train;

% Shuffle the dataset
data = data(randperm(n), :);

% Split into train and test sets
train_data = data(1:n_train, :);
test_data = data(n_train+1:n, :);

% Calculate min and max cherries packed using the provided formula for the train dataset
minCherriesPacked_train = floor(train_data(:, 2).^2 .* train_data(:, 3) ./ (2 .* train_data(:, 1).^3));
maxCherriesPacked_train = floor(0.74 * 3 * train_data(:, 2).^2 .* train_data(:, 3) ./ (4 .* train_data(:, 1).^3));

% Display the min and max cherries packed for the train dataset
fprintf('Min Cherries Packed (Train): %s\n', mat2str(minCherriesPacked_train));
fprintf('Max Cherries Packed (Train): %s\n', mat2str(maxCherriesPacked_train));

% Fit a polynomial curve to the train data for minCherriesPacked
x = train_data(:, 1); % r values
y = minCherriesPacked_train;
degree = 2; % Choose the degree of the polynomial curve

% Fit the polynomial curve
p_min = polyfit(x, y, degree);

% Predict minCherriesPacked on the test dataset
x_test = test_data(:, 1); % r values
minCherriesPacked_pred = floor(polyval(p_min, x_test));

% Fit a polynomial curve to the train data for maxCherriesPacked
y = maxCherriesPacked_train;

% Fit the polynomial curve
p_max = polyfit(x, y, degree);

% Predict maxCherriesPacked on the test dataset
maxCherriesPacked_pred = floor(polyval(p_max, x_test));

% Display predictions
fprintf('Predicted minCherriesPacked on Test Data: %s\n', mat2str(minCherriesPacked_pred));
fprintf('Predicted maxCherriesPacked on Test Data: %s\n', mat2str(maxCherriesPacked_pred));

% Calculate min and max cherries packed for the test dataset using the formulas
minCherriesPacked_test = floor(test_data(:, 2).^2 .* test_data(:, 3) ./ (2 .* test_data(:, 1).^3));
maxCherriesPacked_test = floor(0.74 * 3 * test_data(:, 2).^2 .* test_data(:, 3) ./ (4 .* test_data(:, 1).^3));

% Predict minCherriesPacked and maxCherriesPacked using the fitted curves
minCherriesPacked_pred = floor(polyval(p_min, test_data(:, 1))); % Predict minCherriesPacked
maxCherriesPacked_pred = floor(polyval(p_max, test_data(:, 1))); % Predict maxCherriesPacked

% Create a table of values with the additional prediction columns
dataTable = table(test_data(:, 1), test_data(:, 2), test_data(:, 3), ...
    minCherriesPacked_test, maxCherriesPacked_test, ...
    minCherriesPacked_pred, maxCherriesPacked_pred, ...
    'VariableNames', {'r', 'R', 'h', 'minCherriesPacked', 'maxCherriesPacked', 'minCherriesPacked_pred', 'maxCherriesPacked_pred'});

% Display the table
disp(dataTable);

% Create a scatter plot for minCherriesPacked and minCherriesPacked_pred
figure;
subplot(1, 2, 1);
scatter(minCherriesPacked_test, minCherriesPacked_pred, 'b', 'filled');
xlabel('Actual minCherriesPacked');
ylabel('Predicted minCherriesPacked');
title('Actual vs. Predicted minCherriesPacked');

% Create a scatter plot for maxCherriesPacked and maxCherriesPacked_pred
subplot(1, 2, 2);
scatter(maxCherriesPacked_test, maxCherriesPacked_pred, 'r', 'filled');
xlabel('Actual maxCherriesPacked');
ylabel('Predicted maxCherriesPacked');
title('Actual vs. Predicted maxCherriesPacked');

% Adjust figure properties
sgtitle('Scatter Plots of Actual vs. Predicted Cherries Packed');

