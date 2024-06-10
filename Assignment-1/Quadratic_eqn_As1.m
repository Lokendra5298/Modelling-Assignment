% Generate random values for a, b, and c
a = rand()
b = rand()
c = rand()

% Define the quadratic equation as a function
quad_eq = @(x, a, b, c) a*x.^2 + b*x + c;

% Create a range of x values
x_values = linspace(-10, 10, 100); % Adjust the range as needed

% Generate random noise for the data points
noise = 0.1 * randn(size(x_values));

% Calculate the corresponding y values using the quadratic equation
y_values = quad_eq(x_values, a, b, c) + noise;

% Use curve fitting to estimate the coefficients a, b, and c
fit_coeff = fit(x_values', y_values', 'poly2');

% Extract the estimated coefficients
a_estimate = fit_coeff.p1;
b_estimate = fit_coeff.p2;
c_estimate = fit_coeff.p3;

% Calculate the roots using the estimated coefficients
D_estimate = b_estimate^2 - 4*a_estimate*c_estimate;
if D_estimate > 0
    x1_estimate = (-b_estimate + sqrt(D_estimate)) / (2*a_estimate);
    x2_estimate = (-b_estimate - sqrt(D_estimate)) / (2*a_estimate);
    fprintf('Estimated roots using curve fitting: x1 = %.2f, x2 = %.2f\n', x1_estimate, x2_estimate);
    
elseif D_estimate == 0
    x_estimate = -b_estimate / (2*a_estimate);
    fprintf('Estimated root using curve fitting: x = %.2f\n', x_estimate);
    
else
    realPart_estimate = -b_estimate / (2*a_estimate);
    imaginaryPart_estimate = sqrt(abs(D_estimate)) / (2*a_estimate);
    fprintf('Estimated complex roots using curve fitting: x1 = %.2f + %.2fi, x2 = %.2f - %.2fi\n', realPart_estimate, imaginaryPart_estimate, realPart_estimate, imaginaryPart_estimate);
end
