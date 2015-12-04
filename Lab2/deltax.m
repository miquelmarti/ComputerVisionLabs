function DX = deltax(method)
% Returns a mask for approximation partial derivative in
% x-axis using 'method' method. Supported operators: robert, sobel
if nargin < 1
    method = 'central';
end
switch method
    case 'diff'
        DX=[1,-1;1,-1];
    case 'central'
        DX=[0,0,0,0,0;0,0,0,0,0;0,-1,0,1,0;0,0,0,0,0;0,0,0,0,0]*1/2;
    case 'sobel'
        DX=[-1,0,1;-2,0,2;-1,0,1];
    case 'robert'
        DX=[1,0;0,-1];
end