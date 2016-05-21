rgb = imread('FigP1127_bubbles-0.png'); %load image
rgb = im2double(rgb);
f1=figure;figure(f1);imshow(rgb); title('Original image');
%rgb2 = rgb2gray(rgb); %change it to gray
%f2=figure;figure(f2);imshow(rgb2);title('Changed to grayscale');
rgb2 = imcomplement(rgb); %invert the color
f3=figure;figure(f3);imshow(rgb2);title('Inverted color');
rgb2 = adapthisteq(rgb2, 'ClipLimit', 0.1); %enhance contract
f4=figure;figure(f4);imshow(rgb2);title('Contrast enhanced'); 

%B = (1/159).*[2 4 5 4 2; 4 9 12 9 4; 5 12 15 12 5; 4 9 12 9 4; 2 4 5 4 2];
B = (1/16).*[1 2 1; 2 4 2; 1 2 1];

blurred_im = conv2(double(rgb2), double(B));
figure; imshow(blurred_im); title('Blurred Image');

blurred_im2 = conv2(double(blurred_im), double(B));
figure; imshow(blurred_im2); title('Blurred Image');