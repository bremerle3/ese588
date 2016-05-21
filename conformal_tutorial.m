 %A = imread('grid.png');
  A = imread('clock.PNG ');
 %A = A(31:357,1:388,:);
 A = A(:,:,:);
 figure
 imshow(A)
 title('Original Image','FontSize',14)
 
 conformal = maketform('custom', 2, 2, [], @myConformalTransform, []);
 
uData = [ -1.25   1.25];  % Bounds for REAL(w)
vData = [  0.75  -0.75];  % Bounds for IMAG(w)
xData = [ -2.4    2.4 ];  % Bounds for REAL(z)
yData = [  2.0   -2.0 ];  % Bounds for IMAG(z)

B = imtransform( A, conformal, 'cubic', ...
                'UData', uData,'VData', vData,...
                'XData', xData,'YData', yData,...
                'Size', [300 360], 'FillValues', 255 );
figure
imshow(B)
title('Transformed Image','FontSize',14)