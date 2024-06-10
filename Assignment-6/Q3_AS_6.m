% Parameters
lambda = 0.1;  % Transition rate (Poisson process rate parameter)
T = 100;       % Simulation endpoint

% Initialization
current_state = 1;  % Initial state
time = 0;           % Initial time

% Simulation Loop
while time < T
    % Calculate transition rate
    q = lambda;

    % Generate random time until the next transition
    dt = exprnd(1/q);

    % Update time
    time = time + dt;

    % Determine the next state (assuming a two-state Markov chain)
    next_state = 3 - current_state;  % Toggle between states 1 and 2

    % Display the transition information
    fprintf('Time: %.4f, State %d -> State %d\n', time, current_state, next_state);

    % Update current state
    current_state = next_state;
end
