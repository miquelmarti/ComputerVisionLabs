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

% dxtools = conv2(tools, deltax('diff'), 'valid');
% dytools = conv2(tools, deltay('diff'), 'valid');
dxtools = conv2(tools, deltax('central'), 'valid');
dytools = conv2(tools, deltay('central'), 'valid');
% dxtools = conv2(tools, deltax('robert'), 'valid');
% dytools = conv2(tools, deltay('robert'), 'valid');
% dxtools = conv2(tools, deltax('sobel'), 'valid');
% dytools = conv2(tools, deltay('sobel'), 'valid');


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
subplot(1,3,2);
showgrey(dxtools)
title('$dx$','Interpreter','latex')
subplot(1,3,3);
showgrey(dytools)
title('$dy$','Interpreter','latex')


%% Q2-3

figure;
method = 'sobel';
var=1.4;

gradtools = Lv(tools,method,'same',var);
gradhouse = Lv(house,method,'same',var);

j=1;
k=4;
Thinit=80;
Thend=2e3;
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
C=filter2(deltaxxx, x .^2, 'valid');
D=filter2(deltax,y.^2, 'valid');
E=filter2(deltaxy, x.^2.*y.^2, 'valid');
F=filter2(deltaxxy, x.^2.*y .^3, 'valid');

subplot(2,3,1);
showgrey(A,128);
title('$\delta_{x}(x^2)$','Interpreter','latex')
subplot(2,3,2);
showgrey(B,128,-10,10);
title('$\delta_{xx}(x^2)$','Interpreter','latex')
subplot(2,3,3);
showgrey(C,128,-10,10);
title('$\delta_{xxx}(x^2)$','Interpreter','latex')
subplot(2,3,4);
showgrey(D,128,10,-10);
title('$\delta_x(y^2)$','Interpreter','latex')
subplot(2,3,5);
showgrey(E,128);
title('$\delta_{xy}(x^2y^2)$','Interpreter','latex')
subplot(2,3,6);
showgrey(F,128);
title('$\delta_{xxy}(x^3y^3)$','Interpreter','latex')


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

i=1;

subplot(1,2,1);
scale=0.5;
th=200;
edges = extractedge(tools,scale,th,'same');
overlaycurves(tools, edges);
title(['$scale= $',num2str(scale),'$,th=',num2str(th),'$'],'Interpreter','latex')

subplot(1,2,2);
scale=1.4;
th=80;
edges = extractedge(house,scale,th,'same');
overlaycurves(house, edges);
title(['$scale= ',num2str(scale),',th=',num2str(th),'$'],'Interpreter','latex')

%% HOUGH - Q8

[linepar,acc]=houghline(extractedge(small,1,80,'same'),Lv(small,'central','same'),200,200,50,3,3);


