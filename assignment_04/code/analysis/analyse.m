function results = analyse(sln, parameters, to_plot)

% calculate gait quality metrics (distance, step frequency, step length,
% velocity, etc.)
q = sln.Y{1,1}(:,1:3);
dq = sln.Y{1,1}(:,4:end);
t = sln.T{1,1};
tstep = [sln.T{1,1}(1) sln.T{1,1}(end)];


for i=2:10
    q = [q; sln.Y{1,i}(:,1:3)];
    dq = [dq; sln.Y{1,i}(:,4:end)];
    t = [t; sln.T{1,i}];
    tstep = [tstep; sln.T{1,i}(1) sln.T{1,i}(end)];
end

step_number = 1/numel(t):(1/numel(t))*size(tstep,1):size(tstep,1);
parameters = control_hyper_parameters(step_number);

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
u = zeros(numel(t),2);

for i=1:numel(t)
    [x_swf(i), z_swf(i), dx_swf(i), dz_swf(i)] = kin_swf(q(i,:), dq(i,:));
    [x_h(i), z_h(i), dx_h(i), dz_h(i)] = kin_hip(q(i,:), dq(i,:));
    u(i,:) = control(t(i), q(i,:), dq(i,:), q0, dq0, step_number, parameters);
end

% distance
x_h = x_h+ abs(min(x_h));
distance = cumsum(x_h);


step_frequency = 1./t;
step_length = x_swf;


max_vel_hip = max(dx_h(100:end)); %Ignore first 100 samples
min_vel_hip = min(dx_h(100:end));

max_vel_foot = max(dx_swf(100:end));
min_vel_foot = min(dx_swf(100:end));

effort = 1/(2*length(t)*30).*sum(u(:,1).^2+u(:,2).^2);
CoT = effort/(distance(end)-x_h(1));
velocity = mean(dx_h);
height = mean(z_h);

if to_plot
    
    % plot the angles
    figure
    plot(t, q(:,1), t, q(:,2), t, q(:,3))
    hold on
    box on
    xlabel('t [s]'),ylabel('Angle [rad]')
    legend('q1','q2','q3','location','best')
    title('Angles vs time')

    % plot the displacement vs step number
    figure
    plot(step_number', distance) %
    hold on
    box on
    xlabel('step'),ylabel('Displacement [m]')
    legend('x position of the hip','location','best')
    title('Displacement vs step number')
    
    % plot instantaneous and average velocity over time
    figure
    plot(t, dx_swf,'r', t, dx_h, 'b')
    hold on
    plot([t(1) t(end)],[max_vel_foot max_vel_foot],'--r', [t(1) t(end)], [max_vel_hip max_vel_hip], '--b')
    plot([t(1) t(end)], [min_vel_foot min_vel_foot],'--r', [t(1) t(end)], [min_vel_hip min_vel_hip], '--b')
    box on
    xlabel('t [s]'),ylabel('Velocity [m/s]')
    legend('speed of swing foot','speed of hip','min-max velocity of the foot','min-max velocity of the hip','location','best')
    title('Angles vs time')
    
    % Step frequency vs step number
    
    % Torque vs time
    figure
    plot(t, u(:,1),'r', t, u(:,2), 'b')
    hold on
    box on
    xlabel('t [s]'),ylabel('torque')
    legend('u_1','u_2','location','best')
    title('Torque vs time')
    
    % Normalized mean effort
    
    disp(['Normalized mean effort = ',num2str(effort)])
    
    % Cost of transport
    
    disp(['Cost of transport = ',num2str(CoT)])
    
    % Plot angle speed vs angle
    
    figure
    subplot(2,2,1)
    plot(q(:,1), dq(:,1),'b')
    hold on
    xlabel('q_1'),ylabel('dq_1')
    title(' ')
    
    subplot(2,2,2)
    plot(q(:,2), dq(:,2),'b')
    hold on
    xlabel('q_2'),ylabel('dq_2')
    title(' ')
    
    subplot(2,2,3)
    plot(q(:,3), dq(:,3),'b')
    hold on
    xlabel('dq_3'),ylabel('dq_3')
    title(' ')
    
    % plot projections of the limit cycle
   
    % plot actuation
    
end

results = [distance(end), velocity, effort, CoT, height];
end