% Parameters
alpha = 0.5;
beta = 0.2;
gamma = 0.1;
rho = 0.3;
mu_c = 0.05;
mu_f = 0.1;
C_star = 0.8;
sigma = 0.01;  % Placeholder value

% Initial conditions
V0_subclinical = 0.1;  % Choose V0 < V^*
V0_acute_recovery = 1.0;  % Choose V0 > V^*
F0 = 0.5;
C0 = 0.6;
M0 = 0.2;

% Time parameters
tspan = 0:0.1:50;  % Adjust time span as needed

% Solve ODEs for subclinical form
[t_subclinical, y_subclinical] = ode45(@(t, y) subclinical_ode(t, y, alpha, beta, gamma, rho, mu_c, mu_f, C_star, sigma), tspan, [V0_subclinical; F0; C0; M0]);

% Solve ODEs for acute form with normal immune response
[t_acute_normal, y_acute_normal] = ode45(@(t, y) acute_ode(t, y, alpha, beta, gamma, rho, mu_c, mu_f, C_star, sigma), tspan, [V0_acute_recovery; F0; C0; M0]);

% Solve ODEs for acute form with immunodeficiency response
[t_acute_immunodeficient, y_acute_immunodeficient] = ode45(@(t, y) acute_ode(t, y, alpha, beta, gamma, rho, mu_c, mu_f, C_star, sigma), tspan, [V0_acute_recovery; F0; C0; M0]);

% Plot results for subclinical form
figure;
subplot(2, 1, 1);
plot(t_subclinical, y_subclinical(:, 1), 'b-', 'LineWidth', 2);
title('Acute form with normal immune response');
xlabel('Time');
ylabel('Virus Concentration');

% Plot results for acute form with normal immune response
subplot(2, 1, 2);
plot(t_acute_normal, y_acute_normal(:, 1), 'g-', 'LineWidth', 2);
hold on;

% Plot results for acute form with immunodeficiency response
plot(t_acute_immunodeficient, y_acute_immunodeficient(:, 1), 'r--', 'LineWidth', 2);
legend(' Normal immune response', 'Immunodeficiency Response');
title('Acute Form of Disease');
xlabel('Time');
ylabel('Virus Concentration');

% Function for subclinical ODEs
function dydt = subclinical_ode(t, y, alpha, beta, gamma, rho, mu_c, mu_f, C_star, sigma)
    V = y(1);
    F = y(2);
    C = y(3);
    M = y(4);

    dydt = zeros(4, 1);

    dydt(1) = alpha * V - beta * F * V;
    dydt(2) = beta * F * V - mu_f * F;
    dydt(3) = sigma * V - mu_c * (C - C_star);
    dydt(4) = 0;  % No change in M for subclinical form
end

% Function for acute ODEs
function dydt = acute_ode(t, y, alpha, beta, gamma, rho, mu_c, mu_f, C_star, sigma)
    V = y(1);
    F = y(2);
    C = y(3);
    M = y(4);

    dydt = zeros(4, 1);

    dydt(1) = alpha * V - beta * F * V;
    dydt(2) = beta * F * V - mu_f * F;
    dydt(3) = sigma * V - mu_c * (C - C_star);
    dydt(4) = 1 - mu_c / mu_f;  % Change in M for acute form
end
