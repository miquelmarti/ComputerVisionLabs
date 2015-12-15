function prob = mixture_prob(image, K, L, mask)
% function prob = mixture prob(image, K, L, mask)
%L is the number of iterations that Expectation-Maximization is supposed to run.
% The output of the function is an image of probabilities (prob) that
% corresponds to p(ci)

% Let I be a set of pixels and V be a set of K Gaussian components in 3D (R,G,B).
height=size(image,1);
width=size(image,2);
Ivec = single(reshape(image, width*height, 3));
maskvec = reshape(mask, width*height, 1);
% Store all pixels for which mask=1 in a Nx3 matrix
Imasked = Ivec(maskvec==1,:);
% Randomly initialize the K components using masked pixels
[init_seg,mean]=kmeans_segm(Imasked, K, L, 40, 0);
%sigma=diag(ones(3,1));
sigma=ones(3,3);
sigma_vec=cell(K,1);
sigma_vec(:)={sigma};
N=size(init_seg,2);
for i=1:K
    weights(i)=sum(init_seg==i)/N;
end

pi_t=zeros(size(Imasked,1),K);
%myProd = @(A,B) (A'/B)*A;

% Iterate L times
for i=1:L
% Expectation: Compute probabilities P_ik using masked pixels
    for j=1:K
        D=bsxfun(@minus, Ivec, mean(j,:));
        g_t=1/sqrt((2*pi)^3*det(sigma_vec{j}));
        %g=bsxfun(myProd, D,sigma_vec{j});
        for k=1:N
            g(k)=exp(-1/2*D(k,:)/sigma_vec{j}*D(k,:)');
            pi_t(k,j)=weights(j)*g_t*g(k);
            pi_t(k,j)=pi_t(k,j)/sum(pi_t(k,:));
        end
    end
    
% Maximization: Update weights, means and covariances using masked pixels
    weights=sum(pi_t,1)/N;
    for j=1:K
        mean(j,:)=sum(repmat(pi_t(:,j),1,3).*Imasked)/sum(pi_t(:,j));
    end
    for j=1:K
        D=bsxfun(@minus, Imasked, mean(j,:));
        Dp=(repmat(pi_t(:,j),1,3).*D)';
        sigma_vec{j}=Dp*D/sum(pi_t(:,j));
    end
end
% Compute probabilities p(c_i) in Eq.(3) for all pixels I.
prob = pi_t;