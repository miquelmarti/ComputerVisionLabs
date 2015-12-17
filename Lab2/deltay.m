function DY = deltay(method)
% Returns a mask for approximation partial derivative in
% y-axis using 'method' method.
if nargin < 1
    method = 'central';
end
switch method
    case 'diff'
        DY=[-1,1;-1,1]';
    case 'central'
        DY=[0,0,0,0,0;0,0,0,0,0;0,-1,0,1,0;0,0,0,0,0;0,0,0,0,0]'*1/2;
    case 'sobel'
        DY=[-1,0,1;-2,0,2;-1,0,1]';
    case 'robert'
        DY=[0,1;-1,0];
end