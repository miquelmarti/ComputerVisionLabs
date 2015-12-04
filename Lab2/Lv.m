function gradmag = Lv(image, method, shape)
% Compute magnitude of gradient of input image. Shape for convolution and
% method used can be chosen.
if (nargin < 3)
    shape = 'same';
end

Lx = filter2(deltax(method), image, shape);
Ly = filter2(deltay(method), image, shape);

gradmag = Lx.^2 + Ly.^2;