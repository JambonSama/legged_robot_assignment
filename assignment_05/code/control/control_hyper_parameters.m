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

speed_hip = 0.5;
kdx_h = 100;

% Parameters for Top task

% Parameters for swing task
kpx_s = 400.3551;
kdx_s = 400.6488;
kpz_s = 400.6798;
kdz_s = 400.0000;
h = 0.0241;
step_length = 0.25;
speed_swf = 0.9932;

parameters = [speed_hip, kdx_h, kpx_t, kdx_t, kpz_t, kdz_t, leaning_angle, kpx_s, kdx_s, kpz_s, kdz_s, h, step_length, speed_swf]';

end
