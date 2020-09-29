%%
% This function takes the configuration of the 3-link model and plots the 
% 3-link model. 
% q = [q1, q2 ,q3] the generalized coordinates. Try different angles to see
% if your formulas for x1, z1, etc. makes sense. Example: q = [-pi/6, pi/6,
% pi/8]
%%
function visualize(q)
%     [~, ~, ~, l1, l2, l3, ~] = set_parameters;
    l1 = 0.75;
    l2 = 0.75;
    l3 = 0.5;

    q1 = q(1);
    q2 = q(2);
    q3 = q(3);

    x1 = - l1/2*sin(q1);
    z1 = l1/2*cos(q1);
    x2 = - l1*sin(q1) - l2/2*sin(q2);
    z2 = l1*cos(q1) - l2/2*cos(q2);
    x3 = - l1*sin(q1) + l3/2*sin(q3);
    z3 = l1*cos(q1) + l3/2 *cos(q3);

    x_h = -l1*sin(q1);
    z_h = l1*cos(q1);
    x_swf = -l1*sin(q1) -l2*sin(q2);
    z_swf = l1*cos(q1) -l2*cos(q2);
    x_t = -l1*sin(q1) +l3*sin(q3);
    z_t = l1*cos(q1) +l3*cos(q3);

    %% 
    % Here plot a schematic of the configuration of three link biped at the
    % generalized coordinate q = [q1, q2, q3]:
    close all
    line_width = 2;
    marker_size = 40;
    figure
    hold on

    % links
    plot([0, x_h], [0, z_h], 'linewidth', line_width); 
    plot([x_h, x_swf], [z_h, z_swf], 'linewidth', line_width); 
    plot([x_h, x_t], [z_h, z_t], 'linewidth', line_width); 

    % point masses
    plot(x1, z1, '.', 'markersize', marker_size); 
    plot(x2, z2, '.', 'markersize', marker_size); 
    plot(x3, z3, '.', 'markersize', marker_size); 

    % appearance
    axis 'square'
    xlim([-1, 1]);
    ylim([0, 1.2]);
end
