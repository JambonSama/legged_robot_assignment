function u = control(q, dq, q0, dq0, parameters)
% You may call control_hyper_parameters and desired_outputs in this function
% you don't necessarily need to use all the inputs to this control function

% Computation value
B = eval_B();
Bplus = pinv(B);
[~, ~, ~, l1, l2, ~, ~] = set_parameters();
[~, ~, dx_h, ~] = kin_hip(q, dq);
% [x_t, z_t, dx_t, dz_t] = kin_top(q, dq);
[x_swf, ~, dx_swf, dz_swf] = kin_swf(q, dq);

%% Hip task

% Hip parameters
vx_hip = parameters(1);
kdx_h = parameters(2); 

% Task space projection Hip point
J_h = [l1*cos(q(1)), 0, 0; -l1*sin(q(1)), 0, 0];
f_h = [kdx_h*(vx_hip-dx_h); 0];
u_h = Bplus*J_h'*f_h;

%% Top task

% % Top parameters
kpx_t = parameters(3); 
kdx_t = parameters(4);
% kpz_t = parameters(5);
% kdz_t = parameters(6);
angle_t = parameters(7);
% % 
% % Computation ref value Top
% x_t_t = x_h + l3*sin(angle_t);
% z_t_t = z_h + l3*cos(angle_t);
% 
% % Task space projection top point
% J_t = [l1*cos(q(1)), 0, l3*cos(q(3)); -l1*sin(q(1)), 0, -l3*sin(q(3))];
% f_t = [kpx_t*(x_t_t-x_t)+kdx_t*(dx_h-dx_t); kpz_t*(z_t_t-z_t)+kdz_t*(dz_h-dz_t)];
% u_t = Bplus*J_t'*f_t;

% Angle method
u1 = kpx_t*(q(3)-angle_t) + kdx_t*dq(3);
u_t = [u1;0];


%% Swing foot task

% Swing foot parameters
kpx_s = parameters(8);
kdx_s = parameters(9);
kpz_s = parameters(10);
kdz_s = parameters(11);
h = parameters(12);
step_length = parameters(13);

% Task space projection swing point
J_swf = [l1*cos(q(1)), -l2*cos(q(2)), 0; -l1*sin(q(1)), l2*sin(q(2)), 0];
%f_swf = [kpx_s*(step_length/2-x_swf) + kdx_s*(2*vx_hip-dx_swf);kpz_s*(-z_swf)+kdz_s*(dz_ref-dz_swf)];
f_swf = [kpx_s*(step_length/2-x_swf) + kdx_s*(-dx_swf); kpz_s*(h*sin(q(2)))+ kdz_s*(0-dz_swf)];
u_swf = Bplus*J_swf'*f_swf;


%% Compute command
u =  u_h + u_t + u_swf;
% saturate the output torque
%u = [u1; u2];
%u = max(min(u, 30), -30)
end