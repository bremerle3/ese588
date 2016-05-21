im_orig = imread('FigP1127_bubbles-0.png'); %load image
[m,n] = size(im_orig);
figure;imshow(im_orig);title('Original image');
imVec = reshape(im_orig, 1, []); %reshape image into vector
figure;histogram(imVec);title('Image histogram');

threshold = 180;

imVec(imVec < threshold) = 0; %Apply threshold
imVec(imVec >= threshold) = 255;
im_thres = reshape(imVec, m, []);
figure;imshow(im_thres);title('Thresholded Image');

%Blur the image
im_doub = im2double(im_thres);
figure;imshow(im_doub);title('Convert to Double');
%B = (1/159).*[2 4 5 4 2; 4 9 12 9 4; 5 12 15 12 5; 4 9 12 9 4; 2 4 5 4 2];
%B = (1/16).*[1 2 1; 2 4 2; 1 2 1];
mask_size = 9;
B = ones(mask_size,mask_size);
B(4:6,4:6) = 0;
B = (1/sum(sum(B))).*B;
%blurred_doub = conv2(im_doub, double(B));
%Blur again
blurred_doub = conv2(im_doub, double(B));
figure; imshow(blurred_doub); title('Blurred Image');
blurred_im = im2uint8(blurred_doub); 
figure; imshow(blurred_im); title('Back to uint8');

%New threshold
[m2,n2] = size(blurred_im);
imVec = reshape(blurred_im, 1, []);
figure;histogram(imVec);title('Image histogram');

threshold = 64;

imVec(imVec < threshold) = 0; %Apply threshold
imVec(imVec >= threshold) = 255;
im_thres = reshape(imVec, m2, []);
figure;imshow(im_thres);title('Thresholded Image');

%BWdfill = imfill(im2bw(rgb2), 'holes'); %fill holes 
BWdfill = imfill(im_thres, 'holes'); %fill holes 
figure;imshow(BWdfill);title('Fill holes');
pause;
close all;