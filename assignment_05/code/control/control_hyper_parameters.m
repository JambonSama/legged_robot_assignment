% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function.
function parameters = control_hyper_parameters()

	speed_hip = 0.015625000000000;
	kdx_h = 1.762786643747514e+02;

	% Parameters for Top task
	kpx_t = 33.343996656166986;
	kdx_t = 1.120701147940412e+02;
	kpz_t = 0.506184264101015;
	kdz_t = 2;
	leaning_angle = 0.062500000000000;

	% Parameters for swing task
	kpx_s = 52.430783792919290;
	kdx_s = 0.517842810609692;
	h = 0.551900577000140;
	step_length = -0.202932384440879;

    parameters = [speed_hip, kdx_h, kpx_t, kdx_t, kpz_t, kdz_t, leaning_angle, kpx_s, kdx_s, h, step_length]';

end
