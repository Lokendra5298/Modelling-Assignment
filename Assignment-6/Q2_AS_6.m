% Define the parameters
p = 0.4;  % probability parameter
num_steps = 1000;  % number of steps in the simulation

% Initialize the Markov chain
X = zeros(1, num_steps);

% Simulate the Markov chain
for n = 2:num_steps
    Y_n_minus_1 = rand() < p;
    Y_n = rand() < p;
    X(n) = Y_n_minus_1 + 2 * Y_n;
end

% Plot the evolution of the Markov chain
figure;
plot(X, '-o');
xlabel('Steps');
ylabel('State (X_n)');
title('Simulation of Markov Chain');

% Check for convergence to steady-state
tolerance = 1e-6;  % convergence tolerance
converged = false;
convergence_step = 0;

for n = 2:num_steps
    if max(abs(X(n) - X(n-1))) < tolerance
        converged = true;
        convergence_step = n;
        break;
    end
end

% Display results
if converged
    fprintf('The Markov chain converged to steady-state.\n');
    fprintf('Steady-state probabilities: %s\n', num2str(hist(X(convergence_step:end), 0:3) / (num_steps - convergence_step + 1)));
    fprintf('Number of steps to converge: %d\n', convergence_step);
else
    fprintf('The Markov chain did not converge to steady-state within the given number of steps.\n');
end
