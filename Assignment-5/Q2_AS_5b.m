% Define the Lotka-Volterra equations with fishing
a = 4;
b = 2;
c = 1.5;
d = 3;
delta = 0.2;

LV_equations = @(t, y) [y(1) * (a - b * y(2) - delta); y(2) * (c * y(1) - d - delta)];

% Initial conditions
initial_conditions = [10; 5]; % N(0) = 10, P(0) = 5

% Time span for the simulation
time_span = [0 20]; % You can change the time span as needed

% Solve the differential equations using ode45 solver
[t, populations] = ode45(LV_equations, time_span, initial_conditions);

% Extract N(t) and P(t) from the populations matrix
N = populations(:, 1);
P = populations(:, 2);

% Plot the results
figure;

% Plot the trajectories
plot(N, P, 'b');
title('Phase Portrait');
xlabel('Prey (P)');
ylabel('Predator (N)');
grid on;
