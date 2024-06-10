% Define the parameters
a = 4;
b = 2;
c = 1.5;
d = 3;
delta = 0.2;

% Define the function for the ODE
ode = @(t, y) [y(1) * (a - b * y(2) - delta); y(2) * (-d + c * y(1) - delta)];

% Initial conditions
initial_conditions = [10, 5]; % N(0) = 10, P(0) = 5

% Solve the ODE
[t, populations] = ode45(ode, [0, 10], initial_conditions);

% Extract N and P values from populations
N = populations(:, 1);
P = populations(:, 2);

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
