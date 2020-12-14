function u = control(q, dq, q0, dq0, parameters)
% You may call control_hyper_parameters and desired_outputs in this function
% you don't necessarily need to use all the inputs to this control function

	% Computation value
	B = eval_B();
	B_inv = pinv(B);
	[~, ~, ~, l1, l2, ~, ~] = set_parameters();
	[~, ~, dx_hip, ~] = kin_hip(q, dq);
	% [x_top, z_top, dx_top, dz_topt] = kin_top(q, dq);
	[x_swf, ~, dx_swf, dz_swf] = kin_swf(q, dq);

	%% Hip task
	% Hip parameters
	dx_hip_t = parameters(1);
	kdx_hip = parameters(2);

	% Task space projection Hip point
	J_hip = [l1*cos(q(1)), 0, 0; -l1*sin(q(1)), 0, 0];
	f_hip = [kdx_hip*(dx_hip_t-dx_hip); 0];
	u_hip = B_inv*J_hip'*f_hip;

	%% Top task
	% Top parameters
	kpx_top = parameters(3);
	kdx_top = parameters(4);
	% kpz_top = parameters(5);
	% kdz_top = parameters(6);
	leaning_angle = parameters(5);
	%
	% % Computation ref value Top
	% x_top_t = x_hip + l3*sin(leaning_angle);
	% z_top_t = z_hip + l3*cos(leaning_angle);
	%
	% % Task space projection top point
	% J_top = [l1*cos(q(1)), 0, l3*cos(q(3)); -l1*sin(q(1)), 0, -l3*sin(q(3))];
	% f_top = [kpx_top*(x_top_t-x_top)+kdx_top*(dx_hip_t-dx_top); kpz_top*(z_top_t-z_top)+kdz_top*(0-dz_topt)];
	% u_top = B_inv*J_top'*f_top;

	% Angle method
	u_top = [kpx_top * (q(3) - leaning_angle) + kdx_top * dq(3); 0];

	%% Swing foot task
	% Swing foot parameters
	kpx_swf = parameters(6);
	kdx_swf = parameters(7);
	kpz_swf = parameters(8);
	kdz_swf = parameters(9);
	h = parameters(10);
	step_length = parameters(11);

	% Computation ref value Swing foot
	x_swf_t = step_length/2;
	% dx_swf_t = ;
	% dz_swf_t = ;

	% Task space projection swing point
	J_swf = [l1*cos(q(1)), -l2*cos(q(2)), 0; -l1*sin(q(1)), l2*sin(q(2)), 0];
	f_swf = [kpx_swf*(x_swf_t-x_swf) + kdx_swf*(0-dx_swf); kpz_swf*h*sin(q(2))+kdz_swf*(0-dz_swf)];
	u_swf = B_inv*J_swf'*f_swf;

	%% Compute command
	u = u_top + u_hip + u_swf;

	% saturate the output torque
	%u = [u1; u2];
	u = max(min(u, 30), -30);

end
