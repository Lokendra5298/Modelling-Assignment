% Generate synthetic data for d (diffusivity) and t (diffusion time)
rng(0); % Set random seed for reproducibility
n_samples = 100; % Number of data points

% Generate random values for d and t
d = 0.5 + 2 * rand(n_samples, 1); % Diffusivity values between 0.5 and 2
t = 0.1 + 1 * rand(n_samples, 1); % Diffusion time values between 0.1 and 1

% Generate synthetic data using the linear isotropic diffusion equation
% Y = d * t + noise
noise = 0.1 * randn(n_samples, 1); % Gaussian noise
Y = d .* t + noise;

% Split the dataset into training and testing sets (e.g., 80% train, 20% test)
split_ratio = 0.8;
split_idx = round(n_samples * split_ratio);

train_d = d(1:split_idx);
train_t = t(1:split_idx);
train_Y = Y(1:split_idx);

test_d = d(split_idx+1:end);
test_t = t(split_idx+1:end);
test_Y = Y(split_idx+1:end);
% Perform curve fitting on the training data (d and t as predictors, Y as response)
% Here, we assume a linear relationship: Y = a * d * t + b
X_train = [train_d .* train_t, ones(size(train_d))];
coeff = X_train \ train_Y; % Linear regression coefficients

% Predictions on the test dataset
X_test = [test_d .* test_t, ones(size(test_d))];
predicted_Y = X_test * coeff;

% Evaluate the model (e.g., calculate RMSE)
rmse = sqrt(mean((test_Y - predicted_Y).^2));
fprintf('Root Mean Squared Error (RMSE): %.4f\n', rmse);

% Plot the observed vs. predicted values
figure;
scatter(test_Y, predicted_Y);
