%% FFTWAVE
clear
close all
%% Q1

pq=[5,9;9,5;17,9;17,121;5,1;125,1];

for i=1:size(pq,1)
    figure;
    fftwave(pq(i,1),pq(i,2));
end

input('Continue?')
%% Q7
figure;

F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
H = F + 2 * G;

subplot(2,3,1);
showgrey(F)
title('$F$','Interpreter','latex')
subplot(2,3,2);
showgrey(G)
title('$G$','Interpreter','latex')
subplot(2,3,3);
showgrey(H)
title('$H$','Interpreter','latex')

Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);

subplot(2,3,4);
showgrey(log(1 + abs(Fhat)));
title('$\hat{F}$','Interpreter','latex')
subplot(2,3,5);
showgrey(log(1 + abs(Ghat)));
title('$\hat{G}$','Interpreter','latex')
subplot(2,3,6);
showgrey(log(1 + abs(Hhat)));
title('$\hat{H}$','Interpreter','latex')

figure;
subplot(1,2,1)
showgrey(log(1 + abs(fftshift(Hhat))));
title('fftshift+log')
subplot(1,2,2)
showfs(Hhat)
title('showfs')
input('Continue?')
%% Q10

figure;
subplot(1,3,1);
showgrey(F .* G);
title('$F.*G$','Interpreter','latex')
subplot(1,3,2);
showfs(fft2(F .* G));
title('$\mathcal{F}(F.*G)$','Interpreter','latex')
subplot(1,3,3);
showfs(Fhat*Ghat/128^2);
title('$\hat{F}*\hat{G}$','Interpreter','latex')
input('Continue?')
%% Q11

figure;

F2 = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
[zeros(128, 48) ones(128, 32) zeros(128, 48)];
Fhat2 = fft2(F2);

subplot(1,2,1);
showgrey(F2);
title('$F$','Interpreter','latex')
subplot(1,2,2);
showfs(Fhat2);
title('$\hat{F}$','Interpreter','latex')
input('Continue?')
%% Q12

figure;
G2 = rot(F2, 30);
subplot(421)
showgrey(G2)
title('$G\:for\:\alpha=30$','Interpreter','latex')
subplot(422)
Ghat2 = fft2(G2);
showfs(Ghat2);
title('$\hat{G}$','Interpreter','latex')
% subplot(223)
% Hhat2 = rot(fftshift(Ghat2), -alpha );
% showgrey(log(1 + abs(Hhat2)))
% subplot(224)
% H2=ifft2(Hhat2);
% showgrey(abs(H2))

G2 = rot(F2, 45);
subplot(423)
showgrey(G2)
title('$G\:for\:\alpha=45$','Interpreter','latex')
subplot(424)
Ghat2 = fft2(G2);
showfs(Ghat2);
title('$\hat{G}$','Interpreter','latex')


G2 = rot(F2, 60);
subplot(425)
showgrey(G2)
title('$G\:for\:\alpha=60$','Interpreter','latex')
subplot(426)
Ghat2 = fft2(G2);
showfs(Ghat2);
title('$\hat{G}$','Interpreter','latex')


G2 = rot(F2, 90);
subplot(427)
showgrey(G2)
title('$G\:for\:\alpha=90$','Interpreter','latex')
subplot(428)
Ghat2 = fft2(G2);
showfs(Ghat2);
title('$\hat{G}$','Interpreter','latex')
input('Continue?')
%% Q13

figure;
a=10e-10;
img1=phonecalc128;
img2=few128;
img3=nallo128;

img1amp=pow2image(img1,a);
img2amp=pow2image(img2,a);
img3amp=pow2image(img3,a);

img1phase=randphaseimage(img1);
img2phase=randphaseimage(img2);
img3phase=randphaseimage(img3);

subplot(331);
showgrey(img1);
title('Original')
subplot(332);
showgrey(img1amp);
title('Amp. changed')
subplot(333);
showgrey(img1phase);
title('Phase changed')

subplot(334);
showgrey(img2);
subplot(335);
showgrey(img2amp);
subplot(336);
showgrey(img2phase);

subplot(337);
showgrey(img3);
subplot(338);
showgrey(img3amp);
subplot(339);
showgrey(img3phase);
input('Continue?')
%% Q14
figure;
i=1;
for t=[0.1 0.3 1 10 100]
    subplot(5,1,i);
    psf = gaussfft(deltafcn(128, 128), t);
    showgrey(psf);
    title(['t=' num2str(t)],'Interpreter','latex')
    C=variance(psf);
    C(C<=1e-5)=0;
    text(size(psf)+20,size(psf)/2-10,['Variance = ' num2str(C(1,1))],'Interpreter','latex');
    
    i=i+1;
end
input('Continue?')
%% Q16

figure;
i=1;
img1=phonecalc128;
img2=few128;

for t=[1 4 16 64 256]
    subplot(5,2,i);
    psf = gaussfft(img1, t);
    showgrey(psf);
    title(['Image 1 - t=' num2str(t)],'Interpreter','latex')
    subplot(5,2,i+1);
    psf = gaussfft(img2, t);
    showgrey(psf);
    title(['Image 2 - t=' num2str(t)],'Interpreter','latex')
    
    
    i=i+2;
end

input('Continue?')
%% Q17

figure;

office=office256;
add=gaussnoise(office,16);
sap=sapnoise(office,0.1,255);

subplot(3,2,1);
showgrey(office);
offhat=fft2(office);
title('ORIGINAL')
subplot(3,2,2);
showfs(offhat);
title('SPECTRA')

subplot(3,2,3);
showgrey(add);
title('ADD')
addhat=fft2(add);
subplot(3,2,4);
showfs(addhat);

subplot(3,2,5);
showgrey(sap);
title('SAP')
saphat=fft2(sap);
subplot(3,2,6);
showfs(saphat);
%%
figure;
i=1;
for t=[0.5 1 2]
    subplot(3,3,i);
    psf = gaussfft(sap, t);
    showgrey(psf);
    title(['Gauss smoothing - t=' num2str(t)],'Interpreter','latex')
    
    i=i+3;
end
i=2;
for t=[2 4 8]
    subplot(3,3,i);
    psf = medfilt(sap, t);
    showgrey(psf);
    title(['Median filtering - N=' num2str(t)],'Interpreter','latex')
    
    i=i+3;
end
i=3;
for t=[0.05 0.1 0.15]
    subplot(3,3,i);
    psf = ideal(sap, t);
    showgrey(psf);
    title(['Ideal LP filtering - C=' num2str(t)],'Interpreter','latex')
    
    i=i+3;
end
%% 
figure;
i=1;
for t=[0.5 1 2]
    subplot(3,3,i);
    psf = gaussfft(add, t);
    showgrey(psf);
    title(['Gauss smoothing - t=' num2str(t)],'Interpreter','latex')
    
    i=i+3;
end
i=2;
for t=[2 4 8]
    subplot(3,3,i);
    psf = medfilt(add, t);
    showgrey(psf);
    title(['Median filtering - N=' num2str(t)],'Interpreter','latex')
    
    i=i+3;
end
i=3;
for t=[0.05 0.1 0.15]
    subplot(3,3,i);
    psf = ideal(add, t);
    showgrey(psf);
    title(['Ideal LP filtering - C=' num2str(t)],'Interpreter','latex')
    
    i=i+3;
end
input('Continue?')
%% Q19

f1=figure;
f2=figure;
img = phonecalc256;
smoothimg = gaussfft(img,20);
N=5;
for i=1:N
    if i>1 % generate subsampled versions
        img = rawsubsample(img);
        smoothimg = rawsubsample(smoothimg);
    end
    figure(f1)
    subplot(2, N, i)
    showgrey(img)
    subplot(2, N, i+N)
    showgrey(smoothimg)
    figure(f2)
    subplot(2, N, i)
    showfs(fft2(img))
    subplot(2, N, i+N)
    showfs(fft2(smoothimg))
    
end

%% 

f1=figure;
f2=figure;
img = phonecalc256;
smoothimg = ideal(img,0.06);
N=5;
for i=1:N
    if i>1 % generate subsampled versions
        img = rawsubsample(img);
        smoothimg = rawsubsample(smoothimg);
    end
    figure(f1)
    subplot(2, N, i)
    showgrey(img)
    subplot(2, N, i+N)
    showgrey(smoothimg)
    figure(f2)
    subplot(2, N, i)
    showfs(fft2(img))
    subplot(2, N, i+N)
    showfs(fft2(smoothimg))
    
end