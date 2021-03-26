function dy = eqns(t, y, y0, stepnum, parameters)
% n this is the dimension of the ODE, note that n is 2*DOF, why?
% y1 = q1, y2 = q2, y3 = q3, y4 = dq1, y5 = dq2, y6 = dq3
% y0 is the states right after impact

	persistent start_noise
	tau_pert = 0;
	noise_q = [0;0;0];
	noise_dq = [0;0;0];

	q = [y(1); y(2); y(3)];
	dq = [y(4); y(5); y(6)];

	q0 = [y0(1); y0(2); y0(3)];
	dq0 = [y0(4); y0(5); y0(6)];

	M = eval_M(q);
	C = eval_C(q, dq);
	G = eval_G(q);
	B = eval_B();

    % Perturbation intern and extern
%     if(stepnum>35)
%         if isempty(start_noise)
%             start_noise = t;
%         end
%         if(t-start_noise<0.2)
%             Extern : Force on hip
%             f = [-15;0];
%             [~, ~, ~, l1, ~, ~, ~] = set_parameters();
%             J_hip = [l1*cos(q(1)), 0, 0; -l1*sin(q(1)), 0, 0];
%             tau_pert = J_hip' * f;
% 
%         else
%             tau_pert = 0;
%         end
%         Intern : Noise on q and dq
%          noise = normrnd(0, 0.1);
%          noise_q = [0;0;0];
%          noise_dq = [noise;0;0];
%     end

	u = control(q+noise_q, dq+noise_dq, q0, dq0, parameters);

	n = 6;
	dy = zeros(n, 1);
	dy(1) = y(4);
	dy(2) = y(5);
	dy(3) = y(6);
	dy(4:6) = M \ (-C*dq - G + B*u + tau_pert);

end
