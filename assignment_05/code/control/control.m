function u = control(t, q, dq, q0, dq0, step_number, parameters)
% You may call control_hyper_parameters and desired_outputs in this function
% you don't necessarily need to use all the inputs to this control function

% Computation value
B = eval_B();
[~, ~, ~, l1, l2, l3, ~] = set_parameters();
[x_h, z_h, dx_h, dz_h] = kin_hip(q, dq);
[x_t, z_t, dx_t, dz_t] = kin_top(q, dq);
[x_swf, z_swf, dx_swf, dz_swf] = kin_swf(q, dq);

%% Hip task

% Hip parameters
speed_hip = parameters(1);
kdx_h = parameters(2); 

% Task space projection Hip point
J_h = [l1*cos(q(1)), 0, 0; -l1*sin(q(1)), 0, 0];
f_h = [kdx_h*(speed_hip-dx_h); 0];
u_h = pinv(B)*J_h'*f_h;

%% Top task

% Top parameters
kpx_t = parameters(3); 
kdx_t = parameters(4);
kpz_t = parameters(5);
kdz_t = parameters(6);
leaning_angle = parameters(7);

% Computation ref value Top
x_top_t = x_h + sin(leaning_angle);
z_top_t = z_h + cos(leaning_angle);

% Task space projection top point
J_t = [l1*cos(q(1)), 0, l3*cos(q(3)); -l1*sin(q(1)), 0, -l3*sin(q(3))];
f_t = [kpx_t*(x_top_t-x_t)+kdx_t*(-dx_t); kpz_t*(z_top_t-z_t)+kdz_t*(-dz_t)];
u_t = pinv(B)*J_t'*f_t;


%% Swing foot task

% Swing foot parameters
kpx_s = parameters(8);
kdx_s = parameters(9);
kpz_s = parameters(10);
kdz_s = parameters(11);
h = parameters(12);
step_length = parameters(13);
speed_swf = parameters(14);

% Computation ref value Swing foot
x_swf_tc = -step_length/2:0.1:step_length/2;
z_swf_tc = h*cos(2*pi/step_length*x_swf_tc)+h/2;
swf_norm =zeros(numel(x_swf_tc),1);

for i=1:numel(x_swf_tc)
    swf_norm(i) = norm([x_swf z_swf]-[x_swf_tc(i) z_swf_tc(i)]);
end
[~, idx] = min(swf_norm);
x_swf_t = x_swf_tc(idx);
z_swf_t = z_swf_tc(idx);

% Task space projection swing point
J_swf = [l1*cos(q(1)), -l2*cos(q(2)), 0; -l1*sin(q(1)), l2*sin(q(2)), 0];
f_swf = [kpx_s*(x_swf_t-x_swf)+kdx_s*(speed_swf-dx_swf); kpz_s*(z_swf_t-z_swf)];
u_swf = pinv(B)*J_swf'*f_swf;


%% Compute command
u = u_t + u_h + u_swf;

% saturate the output torque
%u = [u1; u2];
%u = max(min(u, 30), -30)

end