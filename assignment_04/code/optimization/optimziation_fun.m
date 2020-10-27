function objective_value = optimziation_fun(parameters)

% extract parameters q0, dq0 and x
q0 = ...
dq0 = ...;
x = ...;

% run simulation
num_steps = 10; % the higher the better, but slow
sln = solve_eqns(q0, dq0, num_steps, x);
results = analyse(sln, x, false);

% calculate metrics such as distance, mean velocity and cost of transport
max_actuation = 30;
effort = ...;
distance = ...;
velocity = ...;
CoT = ...;
objective_value = ...;

% handle corner case when model walks backwards (e.g., objective_value =
% 1000)

% handle case when model falls (e.g., objective_value = 1000)


end

