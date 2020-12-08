% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function. 
function parameters = control_hyper_parameters(step_number)
kpx = 50; % a opti
kpz = 50; % a opti
kdx = 50; % a opti
kdz = 50; % a opti
xd = 0.5*cos(pi/9); % ? voir ?
dxd = 5; % a opti
zd = 0; % normalement 0
dzd = 0; % normalement 0


parameters = [kpx, kpz, kdx, kdz, xd, dxd, zd, dzd]';

end
