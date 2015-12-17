function [linepar,acc] = houghedgeline(pic, scale, gradmagnthreshold, ...
nrho, ntheta, nlines, s,verbose)
% performs an edge detection step and then applies a Hough transform to the result
% pic is the grey-level imag
% scale is the scale at which edges are detected,
% gradmagnthreshold is the threshold of the gradient magnitude.
[edges,lv]=extractedge(pic,scale,gradmagnthreshold,'same');
[linepar,acc]=houghline(edges,lv,nrho,ntheta,gradmagnthreshold,nlines,s,verbose);
if verbose >=1
    figure;
    overlaycurves(pic, linepar);
    title(['$scale= $',num2str(scale),'$,th=',num2str(gradmagnthreshold),'$'],'Interpreter','latex')
end
