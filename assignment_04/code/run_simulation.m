clearvars
close all
clc

%% run simulation
step_num = 10;
optimized_parameters = control_hyper_parameters(step_num);

q0 = optimized_parameters(1:3);
dq0 = optimized_parameters(4:6);

sln = solve_eqns(q0, dq0, step_num, optimized_parameters);
% animate(sln);
analyse(sln, optimized_parameters, true);
