function results = analyse(sln, parameters, to_plot)

	% calculate gait quality metrics (distance, step frequency, step length,
	% velocity, etc.)

	% X for hip, top and swf
	step_num = numel(sln.Y); % number of steps
	y = vertcat(sln.Y{:}); % q and dq vectors
	q = y(:,1:3); % q vector
	dq = y(:,4:6); % dq vector
	t = vertcat(sln.T{:}); % time vector
	dt = t(2)-t(1);
	total_point_num = numel(t); % total number of points

	step_point_num = zeros(step_num,1); % number of point in each step
	step_end_t = zeros(step_num,1); % time at end of each step
	step_length = zeros(step_num,1); % x_hip distance for step
	X_hip = zeros(total_point_num,4); % [x, z, dx, dz] vectors for hip
	X_top = zeros(total_point_num,4); % [x, z, dx, dz] vectors for top

	point_index = 1;
	previous_x_hip = 0;
	previous_x_top = 0;

	[~, z0_hip] = kin_hip(q(1,:), dq(1,:));
	[~, z0_top] = kin_top(q(1,:), dq(1,:));

	for i = 1:step_num
		t_i = sln.T{i};
		step_point_num(i) = numel(t_i);
		step_end_t(i) = t_i(end);
		x_hip_start = kin_hip(q(point_index,:), dq(point_index,:));
		x_top_start = kin_top(q(point_index,:), dq(point_index,:));
		x_swf_start = kin_swf(q(point_index,:), dq(point_index,:));
		for j=1:step_point_num(i)
			[x_hip, z_hip, dx_hip, dz_hip] = kin_hip(q(point_index,:), dq(point_index,:));
			[x_top, z_top, dx_top, dz_top] = kin_top(q(point_index,:), dq(point_index,:));
			X_hip(point_index,:) = [x_hip, z_hip, dx_hip, dz_hip] + [previous_x_hip-x_hip_start,0,0,0];
			X_top(point_index,:) = [x_top, z_top, dx_top, dz_top] + [previous_x_top-x_top_start,0,0,0];
			point_index = point_index + 1;
		end
		previous_x_hip = X_hip(point_index-1,1);
		previous_x_top = X_top(point_index-1,1);

		step_length(i) = kin_swf(q(point_index-1,:), dq(point_index-1,:))-x_swf_start;
	end

	X_hip(:,2) = X_hip(:,2) + z0_hip;
	X_top(:,2) = X_top(:,2) + z0_top;

	% frequency and lambda
	step_lambda = diff(step_end_t);
	step_frequency = 1./step_lambda;

	% bar dx_hip
	bar_dx_hip = zeros(step_num-1,1);
	index_i = 1;
	for i=1:step_num
		index_f = step_point_num(i)-1+index_i;
		bar_dx_hip(i) = mean(X_hip(index_i:index_f,3));
		index_i = step_point_num(i)+1;
	end

	% control vectors
	u = zeros(total_point_num, 2);
	for i=1:total_point_num
		u(i,:) = transpose(control(q(i,:),dq(i,:),0,0,parameters));
	end

	% other metrics
	u_max = 30;
	effort = 1/(2*t(end)*u_max)*dt.*sum(u(:,1).^2+u(:,2).^2);
	cmt = effort/X_hip(end,1);

	% min max mean stats
	index_i = 1; %sum(step_point_num(1:2))+1;

	dx_hip_avg = mean(X_hip(index_i:end,3));
	z_hip_avg = mean(X_hip(index_i:end,2));
	z_top_avg = mean(X_top(index_i:end,2));

	dx_hip_min = min(X_hip(index_i:end,3));
	z_hip_min = min(X_hip(index_i:end,2));
	z_top_min = min(X_top(index_i:end,2));

	dx_hip_max = max(X_hip(index_i:end,3));
	z_hip_max = max(X_hip(index_i:end,2));
	z_top_max = max(X_top(index_i:end,2));

	step_length_avg = mean(step_length(index_i:end));

	if to_plot
		path = "../../report/img/a05_";

		% plot x_h and z_h
		figure
		plot(t, X_hip(:,1))
		grid on
		xlabel("$t$ [s]", "interpreter", "latex")
		ylabel("$x_{h}$ [m]", "interpreter", "latex")
		% fig1 = gcf;
 		% fig1.Position = [1405 853 630 472/2];
		% saveas(fig1, path+"x_h","epsc")

		figure
		plot(t, X_hip(:,2))
		grid on
		xlabel("$t$ [s]", "interpreter", "latex")
		ylabel("$z_{h}$ [m]", "interpreter", "latex")
		% fig2 = gcf;
 		% fig2.Position = [1405 853 630 472/2];
		% saveas(fig2, path+"z_h","epsc")

		% plot dx_h and average dx_h
		figure
		plot(t, X_hip(:,3))
		grid on
		xlabel("$t$ [s]", "interpreter", "latex")
		ylabel("$\dot{x}_{h}$ [m/s]", "interpreter", "latex")
		% fig3 = gcf;
 		% fig3.Position = [1405 853 630/2 472/2];
		% saveas(gcf, path+"dx_h","epsc")

		figure
		plot(1:step_num, bar_dx_hip, ".-")
		grid on
		xlabel("$t$ [s]", "interpreter", "latex")
		ylabel("$\bar{\dot{x}}_{h}$ [m/s]", "interpreter", "latex")
		% fig4 = gcf;
 		% fig4.Position = [1405 853 630/2 472/2];
		% saveas(gcf, path+"average_dx_h","epsc")

		% Step frequency vs step number
		figure
		plot(2:step_num, step_frequency, ".-")
		grid on
		xlabel("Step number", "interpreter", "latex")
		ylabel("$f$ [m]", "interpreter", "latex")
		% fig5 = gcf;
 		% fig5.Position = [1405 853 630/2 472/2];
		% saveas(gcf, path+"step_frequency","epsc")

		figure
		plot(2:step_num, step_lambda, ".-")
		grid on
		xlabel("Step number", "interpreter", "latex")
		ylabel("$\lambda$ [s]", "interpreter", "latex")
		% fig6 = gcf;
 		% fig6.Position = [1405 853 630/2 472/2];
		% saveas(gcf, path+"step_lambda","epsc")

		% Torque vs time
		figure
		plot(t, u(:,1))
		grid on
		xlabel("$t$ [s]", "interpreter", "latex")
		ylabel("$u_1$ [N$\cdot$m]", "interpreter", "latex")
		% fig7 = gcf;
 		% fig7.Position = [1405 853 630/2 472/2];
		% saveas(gcf, path+"control_torques_u1_optimized","epsc")

		figure
		plot(t, u(:,2))
		grid on
		xlabel("$t$ [s]", "interpreter", "latex")
		ylabel("$u_2$ [N$\cdot$m]", "interpreter", "latex")
		% fig8 = gcf;
 		% fig8.Position = [1405 853 630/2 472/2];
		% saveas(gcf, path+"control_torques_u2_optimized","epsc")

		% Plot angle speed vs angle
		figure
		plot(q(:,1), dq(:,1))
		grid on
		xlabel("$q_1$", "interpreter", "latex")
		ylabel("$\dot{q}_1$", "interpreter", "latex")
		% fig9 = gcf;
 		% fig9.Position = [1405 853 630/2 472/2];
		% saveas(gcf, path+"state_space_q1_optimized","epsc")

		figure
		plot(q(:,2), dq(:,2))
		grid on
		xlabel("$q_2$", "interpreter", "latex")
		ylabel("$\dot{q}_2$", "interpreter", "latex")
		% fig10 = gcf;
 		% fig10.Position = [1405 853 630/2 472/2];
		% saveas(gcf, path+"state_space_q2_optimized","epsc")

		figure
		plot(q(:,3), dq(:,3))
		grid on
		xlabel("$q_3$", "interpreter", "latex")
		ylabel("$\dot{q}_3$", "interpreter", "latex")
		% fig11 = gcf;
 		% fig11.Position = [1405 853 630/2 472/2];
		% saveas(gcf, path+"state_space_q3_optimized","epsc")

		figure
		plot(1:step_num, step_length, ".-")
		grid on
		xlabel("Step number", "interpreter", "latex")
		ylabel("step length [m]", "interpreter", "latex")
		% fig12 = gcf;
 		% fig12.Position = [1405 853 630/2 472/2];
		% saveas(gcf, path+"step_length","epsc")

		% Normalized mean effort
		disp(["Normalized mean effort = ",num2str(effort)])

		% Cost of transport
		disp(["Cost of transport = ",num2str(cmt)])

	end

	results = [X_hip(end,1), dx_hip_avg, effort, cmt, z_hip_min, z_top_min, step_length_avg, dx_hip_min, dx_hip_max];

end