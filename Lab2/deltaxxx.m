function DX = deltaxxx()
% Returns a mask for approximation third partial derivative in
% x-axis

DX=filter2(deltax,deltaxx,'same');