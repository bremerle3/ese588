a=imread('moon.jpg');
figure; imagesc(a) 
title('Unfiltered Image'); set(gcf, 'DefaultFigurePosition', [0 0 0.5 0.5]);
b=rgb2hsv(a);
figure; imagesc(b) 
title('Unfiltered Image Value'); colorbar; set(gcf, 'DefaultFigurePosition', [0.5 0 0.5 0.5]);
v=b(:,:,3);
h=[-1 -1 -1; -1 8 -1; -1 -1 -1];
gg=conv2(h,v);
figure; imagesc(gg) 
title('Filtered Image'); colorbar; set(gcf, 'DefaultFigurePosition', [0.5 0.5 0.5 0.5]);
figure; imagesc(gg) 
title('Filtered Image'); colorbar; colormap(gray); set(gcf, 'DefaultFigurePosition', [0 0.5 0.5 0.5]);