close all;
clear;

% Hover
z_des = 0;

% Step
% answer = inputdlg( {'Enter z_des:'},'Input',1,{'20','hsv'});
% z_des = str2num(answer{1})
% Given trajectory generator
trajhandle = @(t) fixed_set_point(t, z_des);

% This is your controller
controlhandle = @controller;

% Run simulation with given trajectory generator and controller
[t, z] = height_control(trajhandle, controlhandle);
