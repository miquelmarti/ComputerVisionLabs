function DX = deltaxxx()
% Returns a mask for approximation third partial derivative in
% x-axis

DX=conv2(deltax,deltaxx,'same');