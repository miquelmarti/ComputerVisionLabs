function edgecurves = extractedge(inpic, scale, threshold, shape)
% ccomputes the edges of an image at arbitrary scale and returns these lists of edge points. If
% the parameter threshold is given, this value shall be used as threshold for the gradient magnitude
% computed at the same scale. Otherwise, no thresholding shall be used and all edge segments will be
% returned.

lv=Lv(discgaussfft(inpic, scale),'central',shape);

if threshold
   lvt=lv>threshold; 
else
    lvt=lv;
end


lvv=Lvvt(discgaussfft(inpic, scale), shape);
lvvv=Lvvvt(discgaussfft(inpic, scale), shape);

edgecurves=zerocrosscurves(lvv,lvvv-0.5);
edgecurves=thresholdcurves(edgecurves,lvt-0.5);