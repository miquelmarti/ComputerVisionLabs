function DX = deltaxy()
% Returns a mask for approximation second partial derivative in
% xy-axis

DX=conv2(deltax,deltay,'same');