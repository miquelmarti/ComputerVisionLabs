function DY = deltaxxy()
% Returns a mask for approximation second partial derivative in
% x-axis and first in y

DY=conv2(deltaxx,deltay,'same');