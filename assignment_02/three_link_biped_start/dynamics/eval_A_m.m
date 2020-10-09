function A_m = eval_A_m(q_m)

addpath('../dynamics/', '../set_parameters/');
[m1, m2, m3, l1, l2, l3, g] = set_parameters();
m = m1;
q1_m = q_m(1);
q2_m = q_m(2);
q3_m = q_m(3);

t2 = l1.^2;
t3 = l2.^2;
t4 = -q2_m;
t5 = -q3_m;
t6 = q1_m+t4;
t7 = q1_m+t5;
t8 = cos(t6);
t9 = cos(t7);
t10 = l1.*l2.*t8;
t13 = (l1.*l3.*m3.*t9)./2.0;
t11 = -t10;
t12 = (m.*t10)./2.0;
t14 = -t13;
A_m = reshape([t12+t14-m.*t2.*(5.0./4.0)-m3.*t2,-m3.*(t2+t11),-m.*t2,t12-(m.*t3)./4.0,-m3.*(t3+t11),0.0,t14-(l3.^2.*m3)./4.0,0.0,0.0],[3,3]);

end