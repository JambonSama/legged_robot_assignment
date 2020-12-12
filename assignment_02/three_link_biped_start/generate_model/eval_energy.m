function [T,V] = eval_energy(q,dq)

	[m1, m2, m3, l1, l2, l3, g] = set_parameters();

	% write the symbolic formulas for x, z of masses m1, m2, m3:
	z1 = l1/2*cos(-q(1));
	z2 = l1*cos(-q(1)) - l2/2*cos(q(2));
	z3 = l1*cos(-q(1)) + l3/2 *cos(q(3));

	dx1 = dq(1)*l1*cos(q(1))/2;
	dz1 = -dq(1)*l1*sin(q(1))/2;
	dx2 = dq(1)*l1*cos(q(1))-dq(2)*l2*cos(q(2))/2;
	dz2 = dq(2)*l2*sin(q(2))/2-dq(1)*l1*sin(q(1));
	dx3 = dq(1)*l1*cos(q(1))+dq(3)*l3*cos(q(3))/2;
	dz3 = -dq(1)*l1*sin(q(1))-dq(3)*l3*sin(q(3))/2;

	T = 1/2*(m1*(dx1^2+dz1^2)+m2*(dx2^2+dz2^2)+m3*(dx3^2+dz3^2));
	V = g*(m1*z1+m2*z2+m3*z3);

end
