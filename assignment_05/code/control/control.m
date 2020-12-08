function u = control(t, q, dq, q0, dq0, step_number, parameters)
% You may call control_hyper_parameters and desired_outputs in this function
% you don't necessarily need to use all the inputs to this control function

% extract parameters
kpx = parameters(1);
kpz = parameters(2);
kdx = parameters(3);
kdz = parameters(4);
xd = parameters(5);
dxd = parameters(6);
zd = parameters(7);
dzd = parameters(8);
B = eval_B();
[~, ~, ~, l1, ~, l3, ~] = set_parameters();
[x_h, z_h, dx_h, dz_h] = kin_hip(q, dq);
[x_t, z_t, dx_t, dz_t] = kin_top(q, dq)

% Task space projection
J_h = [l1*cos(q(1)), 0, 0; -l1*sin(q(1)), 0, 0]; % at the hip
J_h2 = [l1*cos(q(1)), 0, l3*cos(q(3)); -l1*sin(q(1)), 0, -l3*sin(q(3))];% point on top
f_h2 = [kpx*(x_h-x_t)+kdx*(dxd-dx_h); kpz*(zd-z_h)+kdz*(dzd-dz_h)];
f_h = [kpx*(xd-x_h)+kdx*(dx_h-dx_t); 0];

u = pinv(B)*J_h'*f_h;

% saturate the output torque
%u = [u1; u2];
u = max(min(u, 30), -30)

end