%Set up figure sizes
screensize = get(0, 'screensize');
defaultPos = get(0, 'DefaultFigurePosition');
fSize = [defaultPos(1,3)/screensize(1,3), defaultPos(1,4)/screensize(1,4)];
%%
%Original image
%a=imread('Bikesgray.jpg');
a=imread('cousins.jpg');
%Convert RGB to HSV, then just get value for grayscale
if(ndims(a) == 3)
    v=rgb2hsv(a);
    a=v(:,:,3);
end
%convert to double for conv2
if (isa(a,'uint8'))
    a=double(a);
end
f1=figure; imagesc(a) 
title('Unfiltered Image'); set(f1, 'Units', 'Normalized', 'Position', cat(2,[0.125 0.5],fSize));colormap(gray);
%%
%Apply filter
Gx=[-1 0 1; -2 0 2; -1 0 1]'; %Sobel x filter
Gy=Gx'; %Sobel y filter
Ax=conv2(Gx,a);
figure; imagesc(Ax)     
title('Gx*a'); colorbar; set(gcf, 'Units', 'Normalized', 'Position',cat(2,[0.625 0.5],fSize));colormap(gray);
Ay=conv2(Gy,a);
figure; imagesc(Ay) 
title('Gy*a'); colorbar; set(gcf, 'Units', 'Normalized', 'Position', cat(2,[0.125 0],fSize));colormap(gray);
%%
%Get gradient magnitude
G=sqrt((Ax.*Ax)+(Ay.*Ay));
figure; imagesc(G) 
title('Image Edges'); colormap(gray); set(gcf, 'Units', 'Normalized', 'Position', cat(2,[0.625 0],fSize));
pause;

figure;imagesc(G(2:end-1, 2:end-1)+a);
title('Add edges to original image');colormap(gray);
pause;
close all;  