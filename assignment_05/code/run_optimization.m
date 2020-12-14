clearvars
close all
clc

%% optimize
% optimize the initial conditions and controller hyper parameters
q0 = [pi/9; -pi/9; 0];
dq0 = [0; 0; 8];
default_parameters = control_hyper_parameters;
x0 = [control_hyper_parameters];

% gs = GlobalSearch('XTolerance',0.01,'MaxTime',1000);
ms = MultiStart('UseParallel',true,'Display','iter');

l = [0;   0;   0;  0;   0;  0;    0;   0;   0;   0;  0;    0; 0.5];
u = [1;  60; 500; 60; 500; 60; pi/3; 500;  60; 500; 60; 0.15; 0.8];

% use fminsearch and optimset to control the MaxIter
options = optimoptions(@fmincon,'Algorithm','interior-point');

problem = createOptimProblem('fmincon','x0',x0,'objective', @optimization_fun,'lb',l,'ub',u,'options',options);
% [x,fming,flagg,outptg,manyminsg] = run(gs,problem);
[x,fval,eflag,output,manymins] = run(ms,problem,600);

% opti = fminsearch(@optimziation_fun,x0,options);

%% Simulate solution
num_steps = 50;
sln = solve_eqns(q0, dq0, num_steps, x);
animate(sln);
results = analyse(sln, x, false);
