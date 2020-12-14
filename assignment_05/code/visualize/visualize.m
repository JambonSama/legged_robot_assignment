%%
% This function takes the configuration of the 3-link model and plots the
% 3-link model.
% q = [q1, q2 ,q3] the generalized coordinates. Try different angles to see
% if your formulas for x1, z1, etc. makes sense. Example: q = [-pi/6, pi/6,
% pi/8]
% r0 is the position of the stance foot in the global frame.
%%
function visualize(q, r0, cmd)
persistent handle_links handle_m1 handle_m2 handle_m3 handle_gnd
	% default r0 = [0; 0]
	if nargin == 1
		r0 = [0; 0];
    end
    
    if nargin == 3
        if cmd == "reset"
            clear handle_links handle_m1 handle_m2 handle_m3 handle_gnd
            return;
        end
    end

	x0 = r0(1);
	z0 = r0(2);

	[~, ~, ~, l1, l2, l3, ~] = set_parameters;
	q1 = q(1);
	q2 = q(2);
	q3 = q(3);

	x1 = (l1*sin(q1))/2 + x0;
	z1 = (l1*cos(q1))/2 + z0;
	x2 = l1*sin(q1) - (l2*sin(q2))/2 + x0;
	z2 = l1*cos(q1) - (l2*cos(q2))/2 + z0;
	x3 = l1*sin(q1) + (l3*sin(q3))/2 + x0;
	z3 = l1*cos(q1) + (l3*cos(q3))/2 + z0;

	x_h = l1*sin(q1) + x0;
	z_h = l1*cos(q1) + z0;
	x_t = l1*sin(q1) + l3*sin(q3) + x0;
	z_t = l1*cos(q1) + l3*cos(q3) + z0;
	x_swf = l1*sin(q1) - l2*sin(q2) + x0;
	z_swf = l1*cos(q1) - l2*cos(q2) + z0;

	%%
	% Here plot a schematic of the configuration of three link biped at the
	% generalized coordinate q = [q1, q2, q3]:
	line_width = 2;
	marker_size = 30;

    if isempty(handle_links)
        % links
        handle_links = plot([x0, x_h], [z0, z_h], [x_h, x_swf], [z_h, z_swf], [x_h, x_t], [z_h, z_t], 'linewidth', line_width);
        hold on
        % point masses
        handle_m1 = plot(x1, z1, '.', 'markersize', marker_size, 'color', '#0072BD');
        handle_m2 = plot(x2, z2, '.', 'markersize', marker_size, 'color', '#D95319');
        handle_m3 = plot(x3, z3, '.', 'markersize', marker_size, 'color', '#EDB120');

        % plot a line for "ground"
        handle_gnd = plot([-1 + x_h, 1 + x_h], [0, 0], 'color', 'black');
        axis 'equal'

        xlabel("x","interpreter","latex")
        ylabel("z","interpreter","latex")
        title("Virtual model (task space projection): robot's gait simulation","interpreter","latex")
        hold off
    else
        handle_links(1).XData = [x0, x_h];
        handle_links(1).YData = [z0, z_h];
        
        handle_links(2).XData = [x_h, x_swf];
        handle_links(2).YData = [z_h, z_swf];
        
        handle_links(3).XData = [x_h, x_t];
        handle_links(3).YData = [z_h, z_t];
        
        handle_m1.XData = x1;
        handle_m1.YData = z1;
        
        handle_m2.XData = x2;
        handle_m2.YData = z2;
        
        handle_m3.XData = x3;
        handle_m3.YData = z3;
        
        handle_gnd.XData = [-1 + x_h, 1 + x_h];
        handle_gnd.YData = [0, 0];
    end

    xlim([-1 + x_h, 1 + x_h]);
    ylim([-0.8, 1.2]);

end
