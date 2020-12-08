function u = control(t, q, dq, q0, dq0, step_number, parameters)
% You may call control_hyper_parameters and desired_outputs in this function
% you don't necessarily need to use all the inputs to this control function

% extract controler parameters
kdx_h = parameters(1); 

kpx_t = parameters(2); 
kdx_t = parameters(3);

kpx_s = parameters(4);
kdx_s = parameters(5);
kpz_s = parameters(6);
kdz_s = parameters(7);

% step trajectory
h = parameters(8);
step_length = parameters(9);
speed_hip = parameters(10);
speed_swf = parameters(11);

% compute value
B = eval_B();
[~, ~, ~, l1, l2, l3, ~] = set_parameters();
[x_swf, z_swf, dx_swf, dz_swf] = kin_swf(q, dq);
[x0_swf, ~, ~, ~] = kin_swf(q0, dq0);
[x_h, z_h, dx_h, dz_h] = kin_hip(q, dq);
[x_t, z_t, dx_t, dz_t] = kin_top(q, dq);
z_swf_target = h *sin(pi/step_length*(x_swf-x0_swf));



% Task space projection Hip point
J_h = [l1*cos(q(1)), 0, 0; -l1*sin(q(1)), 0, 0];
f_h = [kdx_h*(speed_hip-dx_h); 0];
u_h = pinv(B)*J_h'*f_h;

% Task space projection top point
J_t = [l1*cos(q(1)), 0, l3*cos(q(3)); -l1*sin(q(1)), 0, -l3*sin(q(3))];
f_t = [kpx_t*(x_h-x_t)+kdx_t*(dx_h-dx_t); 0];
u_t = pinv(B)*J_t'*f_t;

% Task space projection swing point
J_swf = [l1*cos(q(1)), -l2*cos(q(2)), 0; l2*sin(q(2)), -l1*sin(q(1)), 0];
f_swf = [kdx_s*(speed_swf); kpz_s*(z_swf_target-z_swf)];
u_swf = pinv(B)*J_swf'*f_swf;


% Compute command
u = u_t + u_h + u_swf;

% saturate the output torque
%u = [u1; u2];
u = max(min(u, 30), -30);

end