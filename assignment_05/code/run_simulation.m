clearvars
close all
clc

%% run simulation
q0 = [-0.223658168808781;0.589030765161398;0.683113041303540];
dq0 = [0.890349421890447;-19.4434407299695;1.37590825931334];
num_steps = 10;

default_parameters = control_hyper_parameters;
sln = solve_eqns(q0, dq0, num_steps, default_parameters);
animate(sln);
r = analyse(sln, default_parameters, true);
