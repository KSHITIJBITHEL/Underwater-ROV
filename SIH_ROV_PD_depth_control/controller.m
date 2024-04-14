function [ u ] = controller(~, s, s_des, params)
%PD_CONTROLLER  PD controller for the depth control

%   s: 2x1 vector containing the current state [z; v_z]
%   s_des: 2x1 vector containing desired state [z; v_z]
%   params: robot parameters
flag_proximity=0;
u = (params.mass-params.displaced_mass)*params.gravity; 
if ((abs(s_des(1)-s(1))>4))
    %feed-forward controller
    u =u+  50*(s_des(1)-s(1));
else 
    flag_proximity=1;
end
if s(1)<s_des(1)
    flag_proximity=1;
end
if flag_proximity
    %feedback-control
        u= u+ 50*(s_des(1)-s(1))+40*(s_des(2)-s(2)); 
end   
% fprintf('dz: %d , z: %d, u: %d', s(2), s(1),u);
disp(' ');

end

