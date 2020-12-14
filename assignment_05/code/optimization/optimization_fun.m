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
	w2 = 100;
	w3 = 200;
    w4 = 20;
    w5 = 100;
    w6 = 100;
	dx_hip_t = 0.7; %Desired horizontal velocity
    step_length_t = 0.5;
    z_hip_min_t = 0.35;
    z_top_min_t = 0.6;

	u_max = 30;
	distance_travelled = results(1);
	dx_hip_avg = results(2);
	effort = results(3);
	cmt = results(4);
	z_hip_min = results(5);
    z_top_min = results(6);
    step_length_avg = results(7);

	objective_value = w1*distance_travelled+w2*(dx_hip_t-dx_hip_avg)^2+w3*(step_length_t-step_length_avg)^2+w4*cmt + w5*(z_hip_min_t-z_hip_min) + w6*(z_top_min_t-z_top_min);

	% handle corner case when model walks backwards (e.g., objective_value =
	% 1000)
    if dx_hip_avg<=0
		objective_value = 10000000;
    end

    if cmt<0
		objective_value = 10000000;
    end

    if results(5)<0.3
		objective_value = 10000000;
    end
    
    if z_top_min<0.5
		objective_value = 10000000;
    end
    
%     if objective_value<0
%         objective_value
%         distance_travelled
%         z_hip_average
%         z_top_average
%         CoT
%     end

end
