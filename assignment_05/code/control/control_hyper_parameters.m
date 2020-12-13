% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function. 
function parameters = control_hyper_parameters()

% Parameters for Hip task : speed hip
speed_hip = 0.7;
kdx_h = 20;

% Parameters for Top task
kpx_t = 1.017156038755560e+02;
kdx_t = 4.602501714159913;
kpz_t = 200;
kdz_t = 20;
leaning_angle  = 0.184588705994215;

% Parameters for swing task
kpx_s = 200;
kdx_s = 20;
kpz_s = 200;
kdz_s = 20;
h = 0.1;
step_length = 0.6;


parameters = [speed_hip, kdx_h, kpx_t, kdx_t, kpz_t, kdz_t, leaning_angle, kpx_s, kdx_s, kpz_s, kdz_s, h, step_length]';

end
