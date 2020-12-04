function dy = eqns(t, y)
% n this is the dimension of the ODE, note that n is 2*DOF, why?
% y1 = q1, y2 = q2, y3 = q3, y4 = dq1, y5 = dq2, y6 = dq3

	q = y(1:3);
	dq = y(4:end);
	u = control(q, dq); % for the moment we set the control outputs to zero

	% write down the equations for dy:

	M = eval_M(q);
	B = eval_B();
	C = eval_C(q, dq);
	G = eval_G(q);

	dy = ([dq; M\(B*u-C*dq-G)]);

end
