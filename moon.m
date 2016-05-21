%Set up figure sizes
screensize = get(0, 'screensize');
defaultPos = get(0, 'DefaultFigurePosition');
fSize = [defaultPos(1,3)/screensize(1,3), defaultPos(1,4)/screensize(1,4)];
%%
%Original image
a=imread('moon3.jpg');
f1=figure; imagesc(a) 
title('Unfiltered Image'); set(f1, 'Units', 'Normalized', 'Position', cat(2,[0.125 0.5],fSize));
%%
%HSV original image
b=rgb2hsv(a);
f2=figure; imagesc(b) 
title('Unfiltered Image Value'); colorbar; set(f2, 'Units', 'Normalized', 'Position', cat(2,[0.625 0.5],fSize));
%%
%Apply filter
v=b(:,:,3);
%h=[-1 -1 -1; -1 1 -1; -1 -1 -1]; %Unsharp filter
%h=[-1 -1 -1; -1 16 -1; -1 -1 -1]; %High boost sharpening filter (A>1).
%High pass filter is just original minus lowpass. If we amplify original
%first, this is what we get.
%h=[-1 -1 -1; 0 0 0; 1 1 1]; %Gradient
h=[-1 -1 -1; 0 0 0; 1 1 1]'; %Another gradient
gg=conv2(h,v);
figure; imagesc(gg) 
title('Filtered Image'); colorbar; set(gcf, 'Units', 'Normalized', 'Position', cat(2,[0.125 0],fSize));
%%
%Convert back to grayscale
figure; imagesc(gg) 
title('Filtered Grayscale Image'); colormap(gray); set(gcf, 'Units', 'Normalized', 'Position', cat(2,[0.625 0],fSize));
pause;
close all;  