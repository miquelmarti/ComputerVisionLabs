function DY = deltayy()
% Returns a mask for approximation second partial derivative in
% y-axis

DY=[0,0,0,0,0;0,0,0,0,0;0,1,-2,1,0;0,0,0,0,0;0,0,0,0,0]';