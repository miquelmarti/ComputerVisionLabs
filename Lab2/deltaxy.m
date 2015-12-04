function DX = deltaxy()
% Returns a mask for approximation second partial derivative in
% xy-axis

DX=filter2(deltax,deltay,'same');