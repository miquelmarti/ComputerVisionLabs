function lvv = Lvvt(image, shape)
% Compute magnitude of gradient of input image. Shape for convolution and
% method used can be chosen.
if (nargin < 2)
    shape = 'same';
end

Lx = filter2(deltax, image, shape);
Ly = filter2(deltay, image, shape);
Lxx = filter2(deltaxx, image, shape);
Lyy = filter2(deltayy, image, shape);
Lxy = filter2(deltaxy, image, shape);


lvv = (Lx.^2.*Lxx+2*Lx.*Ly.*Lxy+Ly.^2.*Lyy);
