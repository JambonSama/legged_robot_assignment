function A_p = eval_A_p(q_p)

addpath('../dynamics/', '../set_parameters/');
[m1, ~, m3, l1, l2, l3, ~] = set_parameters();
m = m1;

q1_p = q_p(1);
q2_p = q_p(2);
q3_p = q_p(3);

t2 = l1.^2;
t3 = l2.^2;
t4 = l3.^2;
t5 = -q2_p;
t6 = -q3_p;
t7 = q1_p+t5;
t8 = q1_p+t6;
t9 = cos(t7);
t10 = cos(t8);
t11 = (l1.*l2.*m.*t9)./2.0;
t12 = (l1.*l3.*m3.*t10)./2.0;
t13 = -t12;
A_p = reshape([t11+t13-m.*t2.*(5.0./4.0)-m3.*t2,(l1.*l2.*m3.*t9)./2.0,l1.*l3.*m.*t10.*(-1.0./2.0),t11-(m.*t3)./4.0,m3.*t3.*(-1.0./4.0),0.0,t13-(m3.*t4)./4.0,0.0,m.*t4.*(-1.0./4.0)],[3,3]);

end
