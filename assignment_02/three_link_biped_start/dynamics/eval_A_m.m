function A_m = eval_A_m(q_m)

	[m1, ~, m3, l1, l2, l3, ~] = set_parameters();
	m = m1;
	q1_m = q_m(1);
	q2_m = q_m(2);
	q3_m = q_m(3);

	t2 = l1.^2;
	t3 = l3.^2;
	t4 = -q2_m;
	t5 = -q3_m;
	t6 = q1_m+t4;
	t7 = q1_m+t5;
	t8 = cos(t6);
	t9 = cos(t7);
	A_m = reshape([(m.*t2)./4.0-l1.*l2.*m.*t8-l1.*l2.*m3.*t8-(l1.*l3.*m3.*t9)./2.0,(m3.*t2)./4.0,l1.*l3.*m.*t9.*(-1.0./2.0),(l2.^2.*m)./4.0,0.0,0.0,m3.*t3.*(-1.0./4.0)-(l2.*l3.*m3.*cos(q2_m+t5))./2.0,0.0,m.*t3.*(-1.0./4.0)],[3,3]);

end
