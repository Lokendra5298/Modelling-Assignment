% Define the data
variance = [0.5, 1.0, 1.5, 2.0];
psnr = [24.578, 22.175, 20.775, 19.784];

% Create a plot
figure;
plot(variance, psnr, 'o-', 'LineWidth', 2, 'MarkerSize', 8);
title('Variance vs. PSNR');
xlabel('Variance');
ylabel('PSNR ');
grid on;

% Add data points as labels

% Customize the appearance of the plot (optional)
xlim([0 2.5]); % Adjust the x-axis limits as needed
ylim([0 25]);  % Adjust the y-axis limits as needed
legend('PSNR', 'Location', 'Best');

% Save the plot as an image (optional)
% saveas(gcf, 'variance_vs_psnr_plot.png');
