% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function.
function parameters = control_hyper_parameters()

	speed_hip = 0.39469190257901;
	kdx_h = 20.9433388149472;

	% Parameters for Top task
	kpx_t = 464.481656241219;
	kdx_t = 17.6661211681447;
	kpz_t = 334.354925612187;
	kdz_t = 35.2384882957357;
	leaning_angle = 0.679421100788074;

	% Parameters for swing task
	kpx_s = 435.266795609239;
	kdx_s = 48.8443276366812;
	kpz_s = 0;
	kdz_s = 0;
	h = 0.0377193063318664;
	step_length = 0.570871731031634;

% 	parameters = [speed_hip, kdx_h, kpx_t, kdx_t, kpz_t, kdz_t, leaning_angle, kpx_s, kdx_s, kpz_s, kdz_s, h, step_length]';
    parameters = [speed_hip, kdx_h, kpx_t, kdx_t, kpz_t, kdz_t, leaning_angle, kpx_s, kdx_s, h, step_length]';

end
