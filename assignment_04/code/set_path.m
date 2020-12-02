addpath('./kinematics', './control', './dynamics', './set_parameters/', ...
    './solve_eqns/', './visualize', './analysis', './optimization')

q0 = [pi/9; -pi/9; 0];
dq0 = [0; 0; 8];
x0 = [q0;dq0];