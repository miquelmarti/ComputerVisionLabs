function out = gaussfft(pic,t)
% Convolve pic with two-dimensional Gaussian function of arbitrart variance
% t via a discretization of the Gaussian function in the spatial domain.

pichat = fft2(pic);

[xsize, ysize] = size(pichat);
[xx,yy] = meshgrid(-xsize/2: xsize/2-1, -ysize/2 : ysize/2-1);
gauss=1/2/pi/t*exp(-((xx).^2+(yy).^2)/t/2);
out=ifftshift(abs(ifft2(fft2(gauss).*pichat)));

