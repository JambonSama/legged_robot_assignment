% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function. 
function parameters = control_hyper_parameters(step_number)
% Parameters for Hip task : speed hip
kdx_h = 0; % a opti
% Parameters for Top task
kpx_t = 500; % a opti
kdx_t = 0; % a opti
% Parameters for swing task
kpx_s = 0.345; % ? voir ?
kdx_s = 0.5; % a opti
kpz_s = 0;
kdz_s = 0;

% step trajectory
h = 0; % normalement 0
step_length = 0; % normalement 0
speed_hip = 0;
speed_swf = 0;


parameters = [kdx_h, kpx_t, kdx_t, kpx_s, kdx_s, kpz_s, kdz_s, h, step_length, speed_hip, speed_swf]';

end
