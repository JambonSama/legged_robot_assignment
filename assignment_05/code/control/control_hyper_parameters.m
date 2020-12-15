% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function.
function parameters = control_hyper_parameters()

	dx_hip_t = 0.015625000000000;
	kdx_hip = 1.762786643747514e+02;
	% Parameters for Top task
	kpx_top = 33.343996656166986;
	kdx_top = 1.120701147940412e+02;
	leaning_angle = 0.506184264101015;
	% Parameters for swing task
	kpx_swf = 2;
	kdx_swf = 0.062500000000000;
	kpz_swf = 0.1;
	kdz_swf = 0.517842810609692;
	step_length = 0.551900577000140;

    parameters = [dx_hip_t, kdx_hip, kpx_top, kdx_top, leaning_angle, kpx_swf, kdx_swf, kpz_swf, kdz_swf, step_length]';

end
