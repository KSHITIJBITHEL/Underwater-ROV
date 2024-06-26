function [ rov ] = rov_pos( pos, rot, L, H )
%rov_POS Calculates coordinates of rovrotor's position in world frame
% pos       3x1 position vector [x; y; z];
% rot       3x3 body-to-world rotation matrix
% L         1x1 length of the rov

if nargin < 4; H = 0.05; end

wHb   = [rot pos(:); 0 0 0 1]; % homogeneous transformation from body to world

rovBodyFrame  = [L 0 0 1; 0 L 0 1; -L 0 0 1; 0 -L 0 1; 0 0 0 1; 0 0 H 1]';
rovWorldFrame = wHb * rovBodyFrame;
rov           = rovWorldFrame(1:3, :);

end
