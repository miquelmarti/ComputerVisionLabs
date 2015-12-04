function [linepar acc] = houghedgeline(pic, scale, gradmagnthreshold, ...
nrho, ntheta, nlines, verbose)
% performs an edge detection step and then applies a Hough transform to the result
% pic is the grey-level imag
% scale is the scale at which edges are detected,
% gradmagnthreshold is the threshold of the gradient magnitude.

