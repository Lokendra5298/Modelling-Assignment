% Parameters
a = 4;
b = 2;
c = 1.5;
d = 3;

% Initial conditions
N0 = 10;
P0 = 5;

% Time span for simulation
tspan = [0, 10];

% Define the ODE system
dydt = @(t, y) [y(1)*(a - b*y(2)); -y(2)*(d - c*y(1))];

% Solve the ODEs using ode45
[t, y] = ode45(dydt, tspan, [N0, P0]);

% Extract predator and prey populations
N = y(:, 1);
P = y(:, 2);

% Plot the trajectories
figure;
plot(t, N, 'r', t, P, 'b');
title('Lotka-Volterra Model with Fishing');
xlabel('Time');
ylabel('Population');
legend('Predator (N)', 'Prey (P)');

% Plot phase portrait
figure;
plot(N, P);
title('Phase Portrait');
xlabel('Predator (N)');
ylabel('Prey (P)');
