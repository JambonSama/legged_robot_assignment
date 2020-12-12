% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function. 
function parameters = control_hyper_parameters()

% Parameters for Hip task : speed hip
speed_hip = 2;
kdx_h = 2.2835;

% Parameters for Top task
kpx_t = 502.2274; 
kdx_t = 204.0906;
kpz_t = 482.0316;
kdz_t = 199.0424;
leaning_angle = 0.4631;

% Parameters for swing task
kpx_s = 47.3551;
kdx_s = 43.6488;
kpz_s = 51.6798;
kdz_s = 20.0000;
h = 0.0241;
step_length = 0.2537;
speed_swf = 0.9932;


parameters = [speed_hip, kdx_h, kpx_t, kdx_t, kpz_t, kdz_t, leaning_angle, kpx_s, kdx_s, kpz_s, kdz_s, h, step_length, speed_swf]';

end
