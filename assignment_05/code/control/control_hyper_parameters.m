% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function. 
function parameters = control_hyper_parameters()

% Parameters for Hip task : speed hip
% speed_hip = 0.2;
% kdx_h = 50;
% 
% % Parameters for Top task
% kpx_t = 500; 
% kdx_t = 200;
% kpz_t = 500;
% kdz_t = 200;
% leaning_angle = deg2rad(10);
% 
% % Parameters for swing task
% kpx_s = 50;
% kdx_s = 20;
% kpz_s = 50;
% kdz_s = 20;
% h = 0.05;
% step_length = sin(pi/9)*0.5*2;
% speed_swf = 0.4;

speed_hip = 1.46676224527965;
kdx_h = [5.46250808804220];

% Parameters for Top task
kpx_t = [426.557322446476]; 
kdx_t = [89.2785488728309];
kpz_t = [380.501442146919];
kdz_t = [332.695348222485];
leaning_angle = [0.457670855255575];

% Parameters for swing task
kpx_s = [256.350518366750];
kdx_s = [219.825046834367];
kpz_s = [0.00305433075008477];
kdz_s = [147.426124062991];
h = [0.0122700125515563];
step_length = [0.385330686033988];
speed_swf = [-0.936794979340500];

parameters = [speed_hip, kdx_h, kpx_t, kdx_t, kpz_t, kdz_t, leaning_angle, kpx_s, kdx_s, kpz_s, kdz_s, h, step_length, speed_swf]';

end
