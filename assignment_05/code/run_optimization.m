clc; clear; close all;
%% optimize
% optimize the initial conditions and controller hyper parameters
q0 = [pi/9; -pi/9; 0];
dq0 = [0; 0; 8];
default_parameters = control_hyper_parameters;
x0 = [q0; dq0; control_hyper_parameters];

%gs = GlobalSearch('XTolerance',0.01,'MaxTime',1000);
ms = MultiStart('UseParallel',true,'Display','iter');

% l = [-pi/3; -pi/3; -pi/4; -20; -20; -20; 0; 0; 0; -1000; -2000; -1000; -pi/4; -2000; -1000; -2000; -1000; 0; 0.15; -5];
% u = [pi/3;   pi/3;  pi/3;  20;  20;  20; 5; 3; 2000; 1000; 2000; 1000; pi/4; 2000; 1000; 2000; 1000; 1; 0.6; 7];
l = [-pi/3; -pi/3; -pi/3; -20; -20; -20;  0;     0;    0;    0;    0;    0;    0;    0;     0;    0;   0;    0;     0.05; 0];
u = [ pi/3;  pi/3;  pi/3;  20;  20;  20; 10;  5000; 5000; 5000; 5000; 5000; pi/3; 5000;  5000; 5000; 5000; 0.25;     1;  10];

% use fminsearch and optimset to control the MaxIter
options = optimoptions(@fmincon,'Algorithm','interior-point');

problem = createOptimProblem('fmincon','x0',x0,'objective', @optimziation_fun,'lb',l,'ub',u,'options',options);
%[x,fming,flagg,outptg,manyminsg] = run(gs,problem);
[x,fval,eflag,output,manymins] = run(ms,problem,200);

% opti = fminsearch(@optimziation_fun,x0,options);


%% simulate solution

% extract parameters
q0 = x(1:3);
dq0 = x(4:6);
x_opt = x(7:end);

% simulate
num_steps = 10;
sln = solve_eqns(q0, dq0, num_steps, x_opt);
animate(sln);
results = analyse(sln, x_opt, false);