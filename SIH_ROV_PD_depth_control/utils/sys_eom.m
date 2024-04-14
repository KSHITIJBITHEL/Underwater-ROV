function [ sdot ] = sys_eom(t, s, controlhandle, trajhandle, params)
% sys_eom Differential equation for the height control system

s_des = trajhandle(t);
u_des = controlhandle(t, s, s_des, params);
%Appplying constraint to keep u_des within u_min or u_des
u_clamped = min(max(params.u_min, u_des), params.u_max);

sdot = [s(2);
        u_clamped/params.mass - params.gravity*(1-params.displaced_mass/params.mass)];

end
