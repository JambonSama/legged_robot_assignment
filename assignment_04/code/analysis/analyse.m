function results = analyse(sln, parameters, to_plot)

% calculate gait quality metrics (distance, step frequency, step length,
% velocity, etc.)
q = sln.Y{1,1}(:,1:3);
dq = sln.Y{1,1}(:,4:end);
t = sln.T{1,1};
for i=2:10
    q = [q; sln.Y{1,i}(:,1:3)];
    dq = [dq; sln.Y{1,i}(:,4:end)];
    t = [t; sln.T{1,i}];
end

q0 = q(1,:);
dq0 = dq(1,:);

x_swf = zeros(numel(t),1);
z_swf = zeros(numel(t),1);
dx_swf = zeros(numel(t),1);
dz_swf = zeros(numel(t),1);
x_h = zeros(numel(t),1);
z_h = zeros(numel(t),1);
dx_h = zeros(numel(t),1);
dz_h = zeros(numel(t),1);

for i=1:numel(t)
    [x_swf(i), z_swf(i), dx_swf(i), dz_swf(i)] = kin_swf(q(i,:), dq(i,:));
    [x_h(i), z_h(i), dx_h(i), dz_h(i)] = kin_hip(q(i,:), dq(i,:));
end

distance = cumsum(x_swf);
step_frequency = 1./t;
step_length = x_swf;
step_number = numel(t);

% calculate actuation (you can use the control function)
parameters = control_hyper_parameters(step_number);
u = control(t, q, dq, q0, dq0, step_number, parameters);

if to_plot
    % plot the angles
    figure
    plot(t, q(:,1), t, q(:,2), t, q(:,3))

    % plot the hip position
    figure
    plot(cumsum(x_h), cumsum(z_h))
    
    % plot instantaneous and average velocity
    figure
    plot(t, dx_swf, t, dx_h)
    
    % plot projections of the limit cycle
   
    % plot actuation
    
end

end