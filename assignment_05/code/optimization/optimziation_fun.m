function objective_value = optimziation_fun(y)

% extract parameters q0, dq0 and x
q0 = y(1:3);
dq0 = y(4:6);
x = y(7:end);

% run simulation
num_steps = 10; % the higher the better, but slow
sln = solve_eqns(q0, dq0, num_steps, x);
results = analyse(sln, x, false);

% calculate metrics such as distance, mean velocity and cost of transport
w1 =10;
w2 = 12;
w3 = 50;
dx_hip = 0.5; %Desired horizontal velocity

max_actuation = 30;
distance = results(1);
velocity = results(2);
effort = results(3);
CoT = results(4);
height = results(5);

objective_value = 20*CoT -2000*(height-0.35)-10*distance;

% handle corner case when model walks backwards (e.g., objective_value =
% 1000)
if velocity<=0
    objective_value = 10000000;
end

if CoT<0
    objective_value = 10000000;
end

if distance > 10
    objective_value = 10000000;
end

if results(5)<0.3
    objective_value = 10000000;    
end

end

