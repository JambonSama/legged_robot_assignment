function objective_value = optimization_fun(y)

	% extract parameters q0, dq0 and x
	q0 = y(1:3);
	dq0 = y(4:6);
	x = y(7:end);

	% run simulation
	num_steps = 50; % the higher the better, but slow
	sln = solve_eqns(q0, dq0, num_steps, x);
	results = analyse(sln, x, false);

	% calculate metrics such as distance, mean velocity and cost of transport
	w1 = -10;
	w2 = 1;
	w3 = 100;
    w4 = 200;
    w5 = -200;
	dx_hip = 0.7; %Desired horizontal velocity
    step_length_target = 0.5;
    height_min = 0.35;
    

	max_actuation = 30;
	distance = results(1);
	velocity = results(2);
	effort = results(3);
	CoT = results(4);
	height = results(5);
    step_length = results(6);

	objective_value = w1*distance+w2*(dx_hip-velocity)^2+w3*(step_length_target-step_length)^2+w4*CoT + w5*(height-height_min);

	% handle corner case when model walks backwards (e.g., objective_value =
	% 1000)
	if velocity<=0
		objective_value = 10000000;
	end

	if CoT<0
		objective_value = 10000000;
	end

	if results(5)<0.3
		objective_value = 10000000;
	end

end
