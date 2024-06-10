% Generate synthetic data for linearly independent variables
% Variables: d (diffusivity), t (diffusion time), and sigma (Gaussian standard deviation)
n_samples = 1000; % Number of data samples

% Generate random values for d, t, and sigma within specified ranges
d_min = 0.1;
d_max = 10;
t_min = 0.1;
t_max = 100;
sigma_min = 0.1;
sigma_max = 10;

d = d_min + (d_max - d_min) * rand(n_samples, 1);
t = t_min + (t_max - t_min) * rand(n_samples, 1);
sigma = sigma_min + (sigma_max - sigma_min) * rand(n_samples, 1);

% Calculate the corresponding output (result of Gaussian smoothing)
output = sqrt(2 * t) .* sigma;

% Create a black-box model using linear regression
X = [d, t]; % Independent variables
Y = output; % Dependent variable

% Fit a linear regression model
mdl = fitlm(X, Y);

% Display the model summary
disp(mdl);

% Predict the output for new data
% Example: Predict the output for d = 5 and t = 50
new_d = 5;
new_t = 50;
predicted_output = predict(mdl, [new_d, new_t]);
disp(['Predicted Output for d = ', num2str(new_d), ' and t = ', num2str(new_t), ' is  ', num2str(predicted_output)]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the image
image = imread('logo1.png');

% Generate synthetic data for d (diffusivity) and t (diffusion time)
% Example values:
d = 5;   % Adjust as needed
t = 50;  % Adjust as needed

% Apply Gaussian smoothing to the image using specified d and t
sigma = sqrt(2 * t);
smoothed_image = imgaussfilt(image, sigma, 'FilterSize', 5); % You can adjust the filter size as needed

% Display the original and smoothed images
figure;
subplot(1, 2, 1);
imshow(image);
title('Original Image');

subplot(1, 2, 2);
imshow(smoothed_image);
title(['Smoothed Image (t=', num2str(t), ', d=', num2str(d), ')']);

% Save the smoothed image if needed
% imwrite(smoothed_image, 'smoothed_logo.png');
