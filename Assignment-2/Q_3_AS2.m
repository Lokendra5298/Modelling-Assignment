% Load the image
image = imread('tomo.jpg');

% Add Gaussian noise to the image
sigma = 25;
%noisy_image = imnoise(image, 'gaussian', 0.01);
%noisy_image = imnoise(image, 'poisson');
%noisy_image = imnoise(image, 'speckle');
noisy_image = imnoise(image, 'salt & pepper');

% Display the original and noisy images
%subplot(2, 3, 1);
%imshow(image);
%title('Original Image');

subplot(2, 3, 2);
imshow(noisy_image);
title('Noisy Image');

% Define different values of sigma (smoothing parameter)
%Variance = [0.5];
%Variance = [1];
%Variance = [1.5];
 Variance = [2];

% Number of diffusion iterations
num_iterations = 5;

% Initialize a table to store PSNR and MSE values
psnr_mse_table = table(Variance', 'VariableNames', {'Variance'});

% Clean the noisy image for different sigma values
for i = 1:length(Variance)
    sigma = Variance(i);
    
    % Apply Gaussian filter for smoothing
    cleaned_image = noisy_image;  % Initialize cleaned_image with noisy_image
    for j = 1:num_iterations
        cleaned_image = imgaussfilt(cleaned_image, sigma);
    end
    
    % Calculate PSNR
    mse = mean((double(image(:)) - double(cleaned_image(:))).^2);
    max_pixel_value = double(max(image(:)));
    psnr = 10 * log10((max_pixel_value^2) / mse);
    
    % Store PSNR and MSE in the table
    psnr_mse_table.PSNR(i) = psnr;
    psnr_mse_table.MSE(i) = mse;
    
    % Display the cleaned image
    subplot(2, 3, i + 2);
    imshow(uint8(cleaned_image));
    title(['\sigma = ', num2str(sigma), ', PSNR = ', num2str(psnr), ', MSE = ', num2str(mse)]);
end

% Display the PSNR and MSE table
disp('PSNR and MSE Table:');
disp(psnr_mse_table);

% Plot Smoothing Parameter vs. PSNR
figure;
subplot(2, 1, 1);
plot(Variance, psnr_mse_table.PSNR, '-o');
xlabel('Variance (\sigma)');
ylabel('PSNR (dB)');
title('Variance vs. PSNR');
grid on;

% Plot Smoothing Parameter vs. MSE
subplot(2, 1, 2);
plot(Variance, psnr_mse_table.MSE, '-o');
xlabel('Variance (\sigma)');
ylabel('MSE');
title('Variance vs. MSE');
grid on;

% Ensure subplots are properly displayed
set(gcf, 'Position', get(0,'Screensize'));
