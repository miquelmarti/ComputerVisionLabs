function lvvv = Lvvvt(image, shape)
% Compute magnitude of gradient of input image. Shape for convolution and
% method used can be chosen.
if (nargin < 2)
    shape = 'same';
end

Lx = filter2(deltax, image, shape);
Ly = filter2(deltay, image, shape);
Lx3 = filter2(deltaxxx, image, shape);
Ly3 = filter2(deltayyy, image, shape);
Lxyy = filter2(deltaxy, image, shape);
Lxxy = filter2(deltaxy, image, shape);


lvvv = Lx.^3.*Lx3+3*Lx.^2.*Ly.*Lxxy+3*Lx.*Ly.^2.*Lxyy+Ly.^3.*Ly3;
