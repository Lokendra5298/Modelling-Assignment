% Define the Lotka-Volterra equations with fishing
LV_fishing_equations = @(t, y) [y(1) * (4 - 2 * y(2) - 0.2); y(2) * (1.5 * y(1) - 3 - 0.2)];

% Initial conditions
initial_conditions = [10; 5]; % N(0) = 10, P(0) = 5

% Time span for the simulation
time_span = [0 10]; % You can change the time span as needed

% Solve the differential equations using ode45 solver
[t, populations] = ode45(LV_fishing_equations, time_span, initial_conditions);

% Extract N(t) and P(t) from the populations matrix
N = populations(:, 1)
P = populations(:, 2)

% Plot the results
figure;
plot(t, N, 'b', t, P, 'r');
title('Lotka-Volterra Model with Fishing (\delta = 0.2)');
xlabel('Time');
ylabel('Population');
legend('Prey (P)', 'Predator (N)');
grid on;
