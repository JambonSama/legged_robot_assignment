function objective_value = optimization_fun(y)

	% extract parameters q0, dq0 and x
    q0 = [pi/9; -pi/9; 0];
    dq0 = [0; 0; 8];
	x = y(1:end);

	% run simulation
	num_steps = 50; % the higher the better, but slow
	sln = solve_eqns(q0, dq0, num_steps, x);
	results = analyse(sln, x, false);

	% calculate metrics such as distance, mean velocity and cost of transport
	w1 = 0;
	w2 = 20;
	w3 = 100;
    w4 = 200;
    w5 = 500;
    w6 = 500;
	dx_hip_target = 0.7; %Desired horizontal velocity
    step_length_target = 0.5;
    z_hip_min = 0.35;
    z_top_min = 0.6;

	max_actuation = 30;
	distance_travelled = results(1);
	dx_hip_average = results(2);
	effort = results(3);
	CoT = results(4);
	z_hip_average = results(5);
    z_top_average = results(6);
    step_length = results(7);

	objective_value = w1*distance_travelled+w2*(dx_hip_target-dx_hip_average)^2+w3*(step_length_target-step_length)^2+w4*CoT + w5*(z_hip_min-z_hip_average) + w6*(z_top_min-z_top_average);

	% handle corner case when model walks backwards (e.g., objective_value =
	% 1000)
	if dx_hip_average<=0
		objective_value = 10000000;
	end

	if CoT<0
		objective_value = 10000000;
	end

	if results(5)<0.3
		objective_value = 10000000;
	end
    
    if objective_value<0
        objective_value
        distance_travelled
        z_hip_average
        z_top_average
        CoT
    end

end
