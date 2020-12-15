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
% ms = MultiStart('UseParallel',true,'Display','iter');

l = [0;   0;   0;   0;    0;   0;   0;   0;   0; 0.2];
u = [1; 200; 200; 200; pi/6; 200; 200; 200; 200;  0.6];

% use fminsearch and optimset to control the MaxIter
% options = optimoptions(@fmincon,'Algorithm','interior-point');
options = optimoptions('ga');
options.Display = 'diagnose';
options.UseParallel = true;
% options.UseVectorized = true;

% problem = createOptimProblem('fmincon','x0',x0,'objective', @optimization_fun,'lb',l,'ub',u,'options',options);
% [x,fming,flagg,outptg,manyminsg] = run(gs,problem);
% [x,fval,eflag,output,manymins] = run(ms,problem,200);

[x, fval, exitflag, output] = ga(@optimization_fun, 11, [], [], [], [], l, u, [], options);

% opti = fminsearch(@optimziation_fun,x0,options);

%% Simulate solution
num_steps = 50;
sln = solve_eqns(q0, dq0, num_steps, x);
animate(sln);
results = analyse(sln, x, true);
