%% 
% This function defines the event function.
% In the three link biped, the event occurs when the swing foot hits the
% ground.
%%
function [value,isterminal,direction] = event_func(t, y)

% you may want to use kin_swf to set the 'value'
[~, z_swf, ~, ~] = kin_swf(y);
value = z_swf;
isterminal = 1;
direction = -1;

end
