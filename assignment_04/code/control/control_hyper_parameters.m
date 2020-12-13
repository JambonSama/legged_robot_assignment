% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function.
function parameters = control_hyper_parameters(step_number)

	q0 = [0.323889422231244; -0.349631033101727; 3.746057355565474e-04];
	dq0 = [2.893713574495857e-04; 1.719756468469975e-04; 8.582647553490407];
	kp1 = 4.525887887658572e+02;
	kp2 = 1.020789834495002e+02;
	kd1 = 95.1508906083903800;
	kd2 = 4.618944533917682;
	alpha = 0.191138272740080;
	parameters = [q0; dq0; kp1; kp2; kd1; kd2; alpha];

end
