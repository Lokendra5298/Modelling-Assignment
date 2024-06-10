syms N P a b c d delta

% Define the equations
dNdt = N * (a - b * P - delta);
dPdt = P * (-d + c * N - delta);

% Find equilibrium points by solving dN/dt = 0 and dP/dt = 0
eq_points = solve(dNdt == 0, dPdt == 0, N, P);

% Display equilibrium points
disp("Equilibrium Points:");
disp(eq_points);

% Linearize the system (Jacobian matrix)
J = jacobian([dNdt, dPdt], [N, P]);

% Initialize arrays to store eigenvalues and eigenvectors
eigenvalues = cell(length(eq_points.N), 1);
eigenvectors = cell(length(eq_points.N), 1);

% Calculate eigenvalues and eigenvectors for each equilibrium point
for i = 1:length(eq_points.N)
    % Calculate the Jacobian matrix at each equilibrium point
    J_at_point = subs(J, [N, P], [eq_points.N(i), eq_points.P(i)]);
    
    % Compute eigenvalues and eigenvectors directly without attempting to convert to double
    [V, D] = eig(J_at_point);
    eigenvalues{i} = D;
    eigenvectors{i} = V;
end

% Display eigenvalues and eigenvectors for each equilibrium point
for i = 1:length(eq_points.N)
    disp(['Equilibrium Point ' num2str(i)]);
    disp('Eigenvalues:');
    disp(eigenvalues{i});
    disp('Eigenvectors:');
    disp(eigenvectors{i});
end
