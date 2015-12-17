%% Lab2
clear
close all

tools = few256;
house = godthem256;
triangle = triangle128;
ht = houghtest256;
small = binsubsample(triangle);
smallt = binsubsample(binsubsample(ht));

%% Q1
figure;

dxtools1 = conv2(tools, deltax('diff'), 'valid');
dytools1 = conv2(tools, deltay('diff'), 'valid');
dxtools2 = conv2(tools, deltax('central'), 'valid');
dytools2 = conv2(tools, deltay('central'), 'valid');
dxtools3 = conv2(tools, deltax('robert'), 'valid');
dytools3 = conv2(tools, deltay('robert'), 'valid');
dxtools4 = conv2(tools, deltax('sobel'), 'valid');
dytools4 = conv2(tools, deltay('sobel'), 'valid');


% help conv2
% 'full'
% Returns the full two-dimensional convolution (default).
% 'same'
% Returns the central part of the convolution of the same size as A.
% 'valid'
% Returns only those parts of the convolution that are computed without the zero-padded edges. Using this option, size(C) = max([ma-max(0,mb-1),na-max(0,nb-1)],0).

% RESULTS
subplot(1,3,1);
showgrey(tools)
title('$original$','Interpreter','latex')
subplot(4,3,2);
showgrey(dxtools1)
title('$Diff: dx$','Interpreter','latex')
subplot(4,3,3);
showgrey(dytools1)
title('$dy$','Interpreter','latex')
subplot(4,3,5);
showgrey(dxtools2)
title('$Central: dx$','Interpreter','latex')
subplot(4,3,6);
showgrey(dytools2)
title('$dy$','Interpreter','latex')
subplot(4,3,8);
showgrey(dxtools3)
title('$Robert: dx$','Interpreter','latex')
subplot(4,3,9);
showgrey(dytools3)
title('$dy$','Interpreter','latex')
subplot(4,3,11);
showgrey(dxtools4)
title('$Sobel: dx$','Interpreter','latex')
subplot(4,3,12);
showgrey(dytools4)
title('$dy$','Interpreter','latex')

%% Q2-3

figure;
method = 'central';
var=2;
toolsg=discgaussfft(tools,var);
houseg=discgaussfft(house,var);
gradtools = Lv(toolsg,method,'same');
gradhouse = Lv(houseg,method,'same');

j=1;
k=4;
Thinit=25;
Thend=1e2;
Th=linspace(Thinit,Thend,k);
if (strcmp(method,'sobel')) Th=Th*10;end
% RESULTS
for th=Th
    subplot(2,k,j);
    showgrey((gradtools-th)>0);
    title(['$Th=$',num2str(th)],'Interpreter','latex')
    subplot(2,k,j+k);
    showgrey((gradhouse-th)>0);
    title(['$Th=$',num2str(th)],'Interpreter','latex')
    j=j+1;
end



%% Q4prev

figure;

[x,y] = meshgrid(-5:5, -5:5);

A=filter2(deltax,x.^2, 'valid');
B=filter2(deltaxx, x.^2, 'valid');
C=filter2(deltaxx, sign(x), 'valid');
D=filter2(deltaxxx, sign(x), 'valid');
E=filter2(deltaxy, x.^2.*y.^2, 'valid');
F=filter2(deltaxxy, x.^2.*y .^3, 'valid');



subplot(2,3,1);
showgrey(A,128);
title('$\delta_{x}(x^2)$','Interpreter','latex')
subplot(2,3,2);
showgrey(B,128,-10,10);
title('$\delta_{xx}(x^2)$','Interpreter','latex')
subplot(2,3,3);
showgrey(C,128);
title('$\delta_{xx}(sign(x))$','Interpreter','latex')
subplot(2,3,4);
showgrey(D,128);
title('$\delta_{xxx}(sign(x))$','Interpreter','latex')
subplot(2,3,5);
showgrey(E,128);
title('$\delta_{xy}(x^2y^2)$','Interpreter','latex')
subplot(2,3,6);
showgrey(F,128);
title('$\delta_{xxy}(x^2y^3)$','Interpreter','latex')


%% Q4
figure;

% v = VideoWriter('newfile.avi');
% open(v);
i=1;
for scale=[1e-4,1,4,16,64]
subplot(2,5,i);
contour(Lvvt(discgaussfft(house, scale), 'same'), [0 0])
axis('image')
axis('ij')
set(gca,'xtick',[],'ytick',[])
title(['$scale = $',num2str(scale)],'Interpreter','latex')
i=i+1;
% frame = getframe;
% writeVideo(v,frame);
end

% close(v);

%% Q5


i=1;
for scale=[1e-4,1,4,16,64]
subplot(2,5,i+5);
showgrey(Lvvvt(discgaussfft(house, scale), 'same') < 0)
title(['$scale = $',num2str(scale)],'Interpreter','latex')
i=i+1;
end

% Search for the zero-crossings of L~vv that satisfy Lv~vv < 0
% Gives subpixel accuracy and connected edge segments automatically
% Avoids issues of orientation estimation and handling as well as edge
% tracking in discrete non-maximum suppression

%% Q6
figure;

subplot(1,2,1);
scale=2;
th=80;
edges = extractedge(tools,scale,th,'same');
overlaycurves(tools, edges);
title(['$scale= $',num2str(scale),'$,th=',num2str(th),'$'],'Interpreter','latex')

subplot(1,2,2);
scale=2;
th=70;
[edges,~,lvv,lvvv] = extractedge(house,scale,th,'same');
overlaycurves(house, edges);
title(['$scale= ',num2str(scale),',th=',num2str(th),'$'],'Interpreter','latex')
% figure;
% overlaycurves(lvv, edges);
% figure;
% overlaycurves(lvvv<0, edges);

%% HOUGH - Q8

% [linepar,acc]=houghline(extractedge(small,1,80,'valid'),Lv(small,'central','valid'),size(small,1),size(small,2),50,3,2);
%[linepar,acc]=houghline(extractedge(smallt,1,80,'valid'),Lv(smallt,'central','valid'),size(smallt,1),size(smallt,2),100,10,0,2);
[linepar,acc]=houghedgeline(triangle,1,20,400,360,3,0,2);
[linepar,acc]=houghedgeline(ht,1,10,200,180,10,0,2);

[linepar,acc]=houghedgeline(tools,2,80,200,180,10,0,2);
[linepar,acc]=houghedgeline(house,8,2,200,180,10,1,2);
