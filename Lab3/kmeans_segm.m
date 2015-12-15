function [ segmentation, centers ] = kmeans_segm(img, K, L, seed, verbose)
% function [ segmentation, centers ] = kmeans_segm(image, K, L, seed)
% given an image, the number of cluster centers K, number of iterations L
% and a seed for initializing randomization, computes a segmentation
% (with a colour index per pixel) and the centers of all clusters in 3D
% colour space.

VIDEO_FILE='result/kmeans_tiger1.avi';

imgR=double(img);
max_col=max(imgR(:));
height=size(img,1);
% width=size(img,2);
width=1;
%imgR=reshape(imgR,width*height,3); UNCOMMENT FOR FIRST CASES
segmentation=ones(width*height,1);
% Randomly initialize the K cluster centers
if isempty(seed)
    centers = rand([K,3])*max_col;
else
    centers = rand([K,3])*seed-seed+repmat(mean(imgR,1),K,1);
end
% Compute all distances between pixels and cluster centers
dists=pdist2(centers,imgR);

if verbose >=3
    h1=figure;
    if verbose >= 4
        v = VideoWriter(VIDEO_FILE);
        open(v);
        if verbose >=5
            h2=figure;
        end
    end
end

% Iterate L times
for i=1:L
    % If in previous iteration, cluster ends with no members, give it a new
    % center
    %centers(isnan(centers))=rand()*max_col;
    
    % Assign each pixel to the cluster center for which the distance is minimum
    [~,segmentation]=min(dists,[],1);
    % Recompute each cluster center by taking the mean of all pixels assigned to it
    for j=1:K
        centers(j,:)=mean(imgR(segmentation==j,:),1);
    end
    % Recompute all distances between pixels and cluster centers
    dists=pdist2(centers,imgR);
    if verbose >= 3
        figure(h1);
        segImg=zeros(size(imgR));
        segImg(:,1)=centers(segmentation,1);
        segImg(:,2)=centers(segmentation,2);
        segImg(:,3)=centers(segmentation,3);
        segImg=reshape(segImg,height,width,3);
        imshow(segImg/max_col);
        title(['Iteration=',num2str(i)],'Interpreter','Latex')
        if verbose >=4
            frame=getframe;
            writeVideo(v,frame);
            if verbose >=5
                figure(h2);
                subplot(1,round(L),i);
                imshow(segImg/max_col);
                title(['Iteration=',num2str(i)],'Interpreter','Latex')
            end
        end
    end
end
if verbose >= 1
    figure;
    if verbose >=2
        subplot(1,2,1)
        imshow(img)
        title('Original','Interpreter','Latex')
        subplot(1,2,2)
    end
    segImg=zeros(size(imgR));
    segImg(:,1)=centers(segmentation,1);
    segImg(:,2)=centers(segmentation,2);
    segImg(:,3)=centers(segmentation,3);
    segImg=reshape(segImg,height,width,3);
    imshow(segImg/max_col);
    title('Segmented','Interpreter','Latex')
    if verbose >=4
        close(v);
    end
end
%  segmentation=reshape(segmentation,height,width,1); UNCOMMENT FOR FIRST
%  CASES