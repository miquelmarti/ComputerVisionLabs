K = 5;               % number of clusters used
L = 10;              % number of iterations
seed = 14;           % seed used for random initialization
scale_factor = 1.0;  % image downscale factor
image_sigma = 2.0;   % image preblurring scale

I = imread('orange.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

figure;
v = VideoWriter('kmeans.avi');
open(v);

for L=1:30

[ segm, centers ] = kmeans_segm(I, K, L, [], 0);
Ib = overlay_bounds(Iback, segm);
imshow(Ib);
title(['Iteration=',num2str(L)],'Interpreter','Latex')
frame=getframe;
writeVideo(v,frame);
end

close(v);