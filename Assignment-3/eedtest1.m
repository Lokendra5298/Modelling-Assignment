clc
clear all

image_files = {'cameraman.tif', 'tomo.jpg', 'triangle.jpg'};
num_images = numel(image_files);

ref = cell(num_images, 1);
ad = cell(num_images, 1);
psnr_vals = zeros(num_images, 1);
mse_vals = zeros(num_images, 1);
b = cell(num_images, 1);

Niter = 20;
alpha = 2.7;
w = exp(4 * alpha / 9);
k = 0.001;
timestep = 0.2;

% Create separate figures for original, noisy, and denoised images
figure;

for i = 1:num_images
    % Read the image
    image_path = image_files{i};
    a = imread(image_path);
    a = im2double(a);

    % Store reference image
    ref{i} = a;

    % Add Gaussian noise
    ad{i} = imnoise(a, 'gaussian', 0, 0.01);

    % Calculate PSNR and MSE
    [psnr_vals(i), mse_vals(i)] = psnr_mse(ad{i}, ref{i});

    % Denoise using eed and store the result
    b{i} = eed(ad{i}, timestep, Niter, 1, w, 4, k, 3.3148);

    % Display original image
    subplot(num_images, 3, (i - 1) * 3 + 1);
    imshow(a);
    title(sprintf('Original Image %d', i));

    % Display noisy image
    subplot(num_images, 3, (i - 1) * 3 + 2);
    imshow(ad{i});
    title(sprintf('Noisy Image %d', i));

    % Display denoised image
    subplot(num_images, 3, (i - 1) * 3 + 3);
    imshow(b{i});
    title(sprintf('Denoised Image %d', i));
end

% Display PSNR table
fprintf('Image\tPSNR (dB)\n');
for i = 1:num_images
    fprintf('Image %d:\t%.2f\n', i, psnr_vals(i));
end
