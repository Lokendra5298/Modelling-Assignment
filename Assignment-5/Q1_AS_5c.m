% Define the Lotka-Volterra equations with fishing
LV_fishing_equations = @(t, y) [y(1) * (4 - 2 * y(2) - 0.2); y(2) * (1.5 * y(1) - 3 - 0.2)];

% Define the range for plotting the phase portrait
N_range = 0:0.5:8;
P_range = 0:0.5:8;
[x, y] = meshgrid(N_range, P_range);

% Calculate derivatives at each point
dydt1 = x .* (4 - 2 * y - 0.2);
dydt2 = y .* (1.5 * x - 3 - 0.2);

% Normalize the arrows for better visualization
L = sqrt(dydt1.^2 + dydt2.^2);
dydt1 = dydt1 ./ L;
dydt2 = dydt2 ./ L;

% Plot the phase portrait
figure;
quiver(x, y, dydt1, dydt2, 0.5);
title('Lotka-Volterra Model with Fishing Phase Portrait (\delta = 0.2)');
xlabel('Predator (N)');
ylabel('Prey (P)');
axis tight;
hold on;

% Equilibrium points without fishing
N_eq_no_fishing = 3;
P_eq_no_fishing = 4;
plot(N_eq_no_fishing, P_eq_no_fishing, 'ro', 'MarkerSize', 10, 'DisplayName', 'Equilibrium (Without Fishing)');

% Equilibrium points with fishing
N_eq_with_fishing = 3.5;
P_eq_with_fishing = 4.5;
plot(N_eq_with_fishing, P_eq_with_fishing, 'bo', 'MarkerSize', 10, 'DisplayName', 'Equilibrium (With Fishing)');

legend('show');
