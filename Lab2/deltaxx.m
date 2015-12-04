function DX = deltax()
% Returns a mask for approximation second partial derivative in
% x-axis

DX=[0,0,0,0,0;0,0,0,0,0;0,1,-2,1,0;0,0,0,0,0;0,0,0,0,0];