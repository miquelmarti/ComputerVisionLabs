function prob = mixture_prob(img, K, L, mask)
% function prob = mixture prob(image, K, L, mask)
%L is the number of iterations that Expectation-Maximization is supposed to run.
% The output of the function is an image of probabilities (prob) that
% corresponds to p(ci)

% Let I be a set of pixels and V be a set of K Gaussian components in 3D (R,G,B).
height=size(img,1);
width=size(img,2);
Ivec = double(reshape(img, width*height, 3));
maskvec = reshape(mask, width*height, 1);

% Store all pixels for which mask=1 in a Nx3 matrix
Imasked = Ivec(maskvec==1,:);

% Randomly initialize the K components using masked pixels
[init_seg,mean]=kmeans_segm2(Imasked, K, L, 30, 0); % FOR TIGER1 works with seed=30.

sigma=diag([1,1,1]);
sigma_vec=cell(K,1);
sigma_vec(:)={sigma};

N=size(Imasked,1);
weights=zeros(K,1);
for i=1:K
    weights(i)=sum(init_seg==i)/N;
end

pi_t=zeros(size(Imasked,1),K);

% Iterate L times
for i=1:L
% Expectation: Compute probabilities P_ik using masked pixels
    for j=1:K
        D=bsxfun(@minus, Imasked, mean(j,:));
        g_t=1/sqrt((2*pi)^3*det(sigma_vec{j}));
        pi_t(:,j)=weights(j)*g_t*exp(-0.5*sum(D'.*(sigma_vec{j}\D'),1));
% pi_t(:,j)=weights(j)*g_t*exp(-0.5*sum(D'.*(inv(sigma_vec{j})*D'),1));
    end
    pi_t=pi_t./repmat((sum(pi_t,2)+1e-200),1,K);
%     pi_t(isnan(pi_t))=0;
    
% Maximization: Update weights, means and covariances using masked pixels
    weights=sum(pi_t,1)/N;
    for j=1:K
        mean(j,:)=sum(repmat(pi_t(:,j),1,3).*Imasked)/(sum(pi_t(:,j))+1e-200);
    end
    for j=1:K
        D=bsxfun(@minus, Imasked, mean(j,:));
        Dp=(repmat(pi_t(:,j),1,3).*D)';
        sigma_vec{j}=Dp*D/sum(pi_t(:,j)+1e-200);
        if(sigma_vec{j})==0 sigma_vec{j}=sigma;end
        if(sigma_vec{j})<1 sigma_vec{j}=sigma;end
    end
    
end
% Compute probabilities p(c_i) in Eq.(3) for all pixels I.
prob=zeros(size(Ivec,1),K);
for j=1:K
    D=bsxfun(@minus, Ivec, mean(j,:));
    g_t=1/sqrt((2*pi)^3*det(sigma_vec{j}));
    prob(:,j)=weights(j)*g_t*exp(-1/2*sum(D'.*(sigma_vec{j}\D'),1));
end
prob=sum(prob,2);
prob = reshape(prob, height,width);

