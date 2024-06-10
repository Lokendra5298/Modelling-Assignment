T = 100; % Maximum value of t
num_samples = 100; % Number of samples

% Generate random values for t and q
mu_t = T / 2; % Mean of t
sigma_t = T / 3; % Standard deviation of t

mu_q = 5; % Mean of q
sigma_q = 2; % Standard deviation of q

% Generate random samples
t_samples = normrnd(mu_t, sigma_t, 1, num_samples);
q_samples = normrnd(mu_q, sigma_q, 1, num_samples);

% Ensure that generated values are within the specified range
t_samples = max(0, min(T, t_samples));
q_samples = max(0, q_samples);

% Display the generated samples
disp("Generated t samples:");
disp(t_samples);

disp("Generated q samples:");
disp(q_samples);
% Split the generated dataset into train and test datasets
train_ratio = 0.8; % 80% of data for training, 20% for testing
num_train_samples = round(num_samples * train_ratio);
num_test_samples = num_samples - num_train_samples;

% Split the t_samples and q_samples into train and test sets
t_train = t_samples(1:num_train_samples);
q_train = q_samples(1:num_train_samples);

t_test = t_samples(num_train_samples+1:end);
q_test = q_samples(num_train_samples+1:end);

% Initialize an array to store the predicted values x_n
x_n_train = zeros(size(t_train));

% Calculate the predicted variable x_n for the train dataset
for i = 1:num_train_samples
    x_n_train(i) = q_train(i) * (1 - sum(1 ./ factorial(0:i-1)) * (t_train(i) / T) / exp(t_train(i) / T));
end

% Display the predicted x_n for the train dataset
disp("Predicted x_n for the train dataset:");
disp(x_n_train);

% Define the custom function based on the formula
customFunction = @(params, t) params(1) * (1 - sum(1 ./ factorial(0:length(params)-2)) * (t / T) / exp(t / T));

% Initial guess for the parameters (you can adjust these)
initialGuess = [1];

% Fit the curve to the training data
fittedParams = lsqcurvefit(customFunction, initialGuess, t_train, x_n_train);

% Use the fitted parameters to predict x_n for the training data
x_n_train_predicted = customFunction(fittedParams, t_train);
