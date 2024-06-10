% Define symbolic variables
syms V F C m beta gamma rho mu_f eta xi alpha tau mu_c C_star sigma mu_m

% Equations from the infectious disease model
eq1 = (beta - gamma*F)*V;
eq2 = xi*m*alpha*V - mu_c*(C - C_star);
eq3 = rho*C - (mu_f + eta*gamma*V)*F;
eq4 = sigma*V - eta*m;

% Equilibrium points
% Equilibrium Point 1 (Healthy State)
eq_point_1 = [0; rho*C_star/mu_f; C_star; 0];

% Equilibrium Point 2 (Chronic Disease State)
eq_point_2_V = mu_c*(mu_f*beta - gamma*rho*C_star)/(beta*(alpha*gamma - mu_c*eta*gamma));
eq_point_2_F = beta/gamma;
eq_point_2_C = (alpha*mu_f*beta - eta*mu_c*gamma^2*C_star)/(gamma*(alpha*gamma - mu_c*eta*gamma));
eq_point_2_m = sigma*eq_point_2_V/mu_m;
eq_point_2 = [eq_point_2_V; eq_point_2_F; eq_point_2_C; eq_point_2_m];

% Jacobian matrix
Jacobian = jacobian([eq1; eq2; eq3; eq4], [V; F; C; m]);

% Substitute equilibrium points into Jacobian matrix
Jacobian_eq_point_1 = subs(Jacobian, [V; F; C; m], eq_point_1);
Jacobian_eq_point_2 = subs(Jacobian, [V; F; C; m], eq_point_2);

% Eigenvalues of the Jacobian matrix at equilibrium points
eigenvalues_eq_point_1 = eig(Jacobian_eq_point_1);
eigenvalues_eq_point_2 = eig(Jacobian_eq_point_2);

% Display results
disp('Equilibrium Point 1:');
disp('Verification:');
disp(subs([eq1; eq2; eq3; eq4], [V; F; C; m], eq_point_1));
disp('Jacobian Matrix at Equilibrium Point 1:');
disp(Jacobian_eq_point_1);
disp('Eigenvalues at Equilibrium Point 1:');
disp(eigenvalues_eq_point_1);

disp('----------------------------------------');

disp('Equilibrium Point 2:');
disp('Verification:');
disp(subs([eq1; eq2; eq3; eq4], [V; F; C; m], eq_point_2));
disp('Jacobian Matrix at Equilibrium Point 2:');
disp(Jacobian_eq_point_2);
disp('Eigenvalues at Equilibrium Point 2:');
disp(eigenvalues_eq_point_2);
