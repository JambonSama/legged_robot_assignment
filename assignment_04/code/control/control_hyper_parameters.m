% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function.
function parameters = control_hyper_parameters(step_number)

	q0 = [0.330785198702347; -0.349725949617712; 3.701831083377785e-04];
	dq0 = [2.879165500633054e-04; 1.721136813809485e-04; 8.351735805698030];
	kp1 = 4.504379914287889e+02;
	kp2 = 1.017156038755560e+02;
	kd1 = 94.559268587067460;
	kd2 = 4.602501714159913;
	alpha = 0.184588705994215;
	parameters = [q0; dq0; kp1; kp2; kd1; kd2; alpha];

end
