function u = control(t, q, dq, q0, dq0, step_number, parameters)

    % You may call control_hyper_parameters and desired_outputs in this function
    % you don't necessarily need to use all the inputs to this control function

    % extract parameters
    q0 = parameters(1:3);
    dq0 = parameters(4:6);
    kp1 = parameters(7);
    kp2 = parameters(8);
    kd1 = parameters(9);
    kd2 = parameters(10);
    alpha = parameters(11);

    % controller for torso
    u1 = kp1*q(3)-alpha + kd1*dq(3);

    % controller for legs
    u2 = -kp2*(q(2)+q(1)) - kd2*(dq(2)+dq(1));

    % saturate the output torque
    u = [u1; u2];
    u = max(min(u, 30), -30);

end