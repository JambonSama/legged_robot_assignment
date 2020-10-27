function results = analyse(sln, parameters, to_plot)

% calculate gait quality metrics (distance, step frequency, step length,
% velocity, etc.)
% [x_swf, ~, ~, ~] = kin_swf(q, dq);
% r0 = r0+[x_swf, 0];
distance = ;
step_frequency = sln.TE{end}/numel(sln.TE);
step_length = ;
velocity

% calculate actuation (you can use the control function)
parameters = control_hyper_parameters(step_number);
u = control(t, q, dq, q0, dq0, step_number, parameters);

if to_plot
    % plot the angles

    % plot the hip position
    
    % plot instantaneous and average velocity
    
    % plot projections of the limit cycle
   
    % plot actuation
    
end

end