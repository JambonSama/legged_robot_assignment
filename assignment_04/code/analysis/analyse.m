function results = analyse(sln, parameters, to_plot)

	% calculate gait quality metrics (distance, step frequency, step length,
	% velocity, etc.)
	step_num = numel(sln.Y);

	q = [];
	dq = [];
	t = [];
	t_step = [];

	for i=1:step_num
		q = [q; sln.Y{1,i}(:,1:3)];
		dq = [dq; sln.Y{1,i}(:,4:end)];
		t = [t; sln.T{1,i}];
		t_step = [t_step; numel(sln.T{1,i}) sln.T{1,i}(end)];
		if i==1
			[x_h, ~, ~, ~] = kin_hip(q(end,:), dq(end,:));
			distance = x_h;
		else
			[x_h, ~, ~, ~] = kin_hip(q(end,:), dq(end,:));
			[x_b, ~, ~, ~] = kin_hip(q(end-size(sln.Y{1,i}(:,1:3),1)+1,:), dq(end-size(sln.Y{1,i}(:,1:3),1)+1,:));
			distance = distance + x_h - x_b;
		end
	end

	q0 = parameters(1);
	dq0 = parameters(2);

	x_swf = zeros(numel(t),1);
	z_swf = zeros(numel(t),1);
	dx_swf = zeros(numel(t),1);
	dz_swf = zeros(numel(t),1);
	x_h = zeros(numel(t),1);
	z_h = zeros(numel(t),1);
	dx_h = zeros(numel(t),1);
	bar_dx_h = zeros(step_num,1);
	dz_h = zeros(numel(t),1);
	u = zeros(numel(t),2);

	for i=1:numel(t)
		[x_swf(i), z_swf(i), dx_swf(i), dz_swf(i)] = kin_swf(q(i,:), dq(i,:));
		[x_h(i), z_h(i), dx_h(i), dz_h(i)] = kin_hip(q(i,:), dq(i,:));
		u(i,:) = control(0, q(i,:), dq(i,:), q0, dq0, 0, parameters);
	end

	% frequency and lambda
	lambda = diff(t_step(:,2));
	f = 1./lambda;

	% bar dx_h
	bar_dx_h(1) = mean(dx_h(1:t_step(1,1)));
	for i=2:step_num
		bar_dx_h(i) = mean(dx_h(t_step(i-1,1)+1:t_step(i-1,1)+t_step(i,1)));
	end

	% distance
	x_h = x_h + abs(min(x_h));
	distance = cumsum(x_h);

	effort = 1/(2*length(t)*30).*sum(u(:,1).^2+u(:,2).^2);
	CoT = effort/(distance(end)-x_h(1));
	velocity = mean(dx_h); % mean(dx_h(t_step(2,1)+1:end));
	height = mean(z_h);

	if to_plot
		path = "../../report/img/";

		% plot x_h and z_h
		figure
		plot(t, x_h)
		grid on
		xlabel("$t$ [s]", "interpreter", "latex")
		ylabel("$x_{h}$ [m]", "interpreter", "latex")
		fig1 = gcf;
		fig1.Position = [1405 853 630 472/2];
		% saveas(fig1, path+"a04_x_h","epsc")

		figure
		plot(t, z_h)
		grid on
		xlabel("$t$ [s]", "interpreter", "latex")
		ylabel("$z_{h}$ [m]", "interpreter", "latex")
		fig2 = gcf;
		fig2.Position = [1405 853 630 472/2];
		% saveas(fig2, path+"a04_z_h","epsc")

		% plot dx_h and average dx_h
		figure
		plot(t, dx_h)
		grid on
		xlabel("$t$ [s]", "interpreter", "latex")
		ylabel("$\dot{x}_{h}$ [m/s]", "interpreter", "latex")
		fig3 = gcf;
		fig3.Position = [1405 853 630/2 472/2];
		% saveas(gcf;, path+"a04_dx_h","epsc")

		figure
		plot(1:step_num, bar_dx_h, ".-")
		grid on
		xlabel("$t$ [s]", "interpreter", "latex")
		ylabel("$\bar{\dot{x}}_{h}$ [m/s]", "interpreter", "latex")
		fig4 = gcf;
		fig4.Position = [1405 853 630/2 472/2];
		% saveas(gcf;, path+"a04_average_dx_h","epsc")

		% Step frequency vs step number
		figure
		plot(2:step_num, f, ".-")
		grid on
		xlabel("Step number", "interpreter", "latex")
		ylabel("$f$ [m]", "interpreter", "latex")
		fig5 = gcf;
		fig5.Position = [1405 853 630/2 472/2];
		% saveas(gcf;, path+"a04_step_frequency","epsc")

		figure
		plot(2:step_num, lambda, ".-")
		grid on
		xlabel("Step number", "interpreter", "latex")
		ylabel("$\lambda$ [s]", "interpreter", "latex")
		fig6 = gcf;
		fig6.Position = [1405 853 630/2 472/2];
		% saveas(gcf;, path+"a04_step_lambda","epsc")

		% Torque vs time
		figure
		plot(t, u(:,1))
		grid on
		xlabel("$t$ [s]", "interpreter", "latex")
		ylabel("$u_1$ [N$\cdot$m]", "interpreter", "latex")
		fig7 = gcf;
		fig7.Position = [1405 853 630/2 472/2];
		% saveas(gcf;, path+"a04_control_torques_u1_optimized","epsc")

		figure
		plot(t, u(:,2))
		grid on
		xlabel("$t$ [s]", "interpreter", "latex")
		ylabel("$u_2$ [N$\cdot$m]", "interpreter", "latex")
		fig8 = gcf;
		fig8.Position = [1405 853 630/2 472/2];
		% saveas(gcf;, path+"a04_control_torques_u2_optimized","epsc")

		% Plot angle speed vs angle
		figure
		plot(q(:,1), dq(:,1))
		grid on
		xlabel("$q_1$", "interpreter", "latex")
		ylabel("$\dot{q}_1$", "interpreter", "latex")
		fig9 = gcf;
		fig9.Position = [1405 853 630/2 472/2];
		% saveas(gcf;, path+"a04_state_space_q1_optimized","epsc")

		figure
		plot(q(:,2), dq(:,2))
		grid on
		xlabel("$q_2$", "interpreter", "latex")
		ylabel("$\dot{q}_2$", "interpreter", "latex")
		fig10 = gcf;
		fig10.Position = [1405 853 630/2 472/2];
		% saveas(gcf;, path+"a04_state_space_q2_optimized","epsc")

		figure
		plot(q(:,3), dq(:,3))
		grid on
		xlabel("$q_3$", "interpreter", "latex")
		ylabel("$\dot{q}_3$", "interpreter", "latex")
		fig11 = gcf;
		fig11.Position = [1405 853 630/2 472/2];
		% saveas(gcf;, path+"a04_state_space_q3_optimized","epsc")

		% Normalized mean effort
		disp(["Normalized mean effort = ",num2str(effort)])

		% Cost of transport
		disp(["Cost of transport = ",num2str(CoT)])

	end

	results = [distance(end), velocity, effort, CoT, height];


end
