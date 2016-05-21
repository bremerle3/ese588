im_orig = imread('FigP1127_bubbles-0.png'); %load image
[m,n] = size(im_orig);
figure;imshow(im_orig);title('Original image');
imVec = reshape(im_orig, 1, []); %reshape image into vector
figure;h=histogram(imVec);title('Image histogram');
%Estimated mean plus standard deviation from histogram
threshold = 180;
imVec(imVec < threshold) = 0; %Apply threshold
imVec(imVec >= threshold) = 255;
im_thres = reshape(imVec, m, []);
figure;imshow(im_thres);title('Thresholded Image');
%%
%Blur the image
im_doub = im2double(im_thres);
figure;imshow(im_doub);title('Convert to Double');
%Averaging mask does not include center pixels to remove small artifacts
mask_size = 9;
B = ones(mask_size,mask_size);
B(4:6,4:6) = 0;
B = (1/sum(sum(B))).*B;
%Apply blur filter to improve connectedness of bubbles
blurred_doub = conv2(im_doub, double(B));
figure; imshow(blurred_doub); title('Blurred Image');
blurred_im = im2uint8(blurred_doub); 
%%
%Threshold again after the blur
[m2,n2] = size(blurred_im);
imVec = reshape(blurred_im, 1, []);
figure;histogram(imVec);title('Image histogram after blur');
%Estimated mean from histogram
threshold = 40;
imVec(imVec < threshold) = 0; %Apply threshold
imVec(imVec >= threshold) = 255;
im_thres = reshape(imVec, m2, []);
figure;imshow(im_thres);title('Thresholded Image');
%%
%Fill in connected shapes with imfill
BWdfill = imfill(im_thres, 'holes');
figure;imshow(BWdfill);title('Fill holes');
%Find pixel totals for bubbles now
[L1, L2] = size(BWdfill);
totSize = L1*L2;
bw_zeros = length(find(BWdfill == 0));
percent_bubbles = 100*(1 - bw_zeros/totSize)
num_bubble_pixels = totSize - bw_zeros
%Take the distance transform to find maxima
BWdfill_BW = im2bw(BWdfill, 0.4); 
D = bwdist(~BWdfill_BW);
D = D./(max(max(D)));  %Normalize to [0,1]
figure; imshow(D, [], 'InitialMagnification', 'fit');
[m3,n3] = size(D);
imVec = reshape(D, 1, []); %reshape image into vector
figure;histogram(D, 0:0.1:1);title('Distance transform histogram');
%Vast majority are < .2. We want the few maxima, so threshold above
threshold = 0.25;
imVec(imVec < threshold) = 0; %Apply threshold
D_thres = reshape(imVec, m3, []);
figure;imshow(D_thres, [], 'InitialMagnification','fit');title('Thresholded Image');
% Use beconncomp to count number of connected components
% This is the number of bubbles
D_Peaks = im2bw(D_thres, threshold); 
figure;imshow(D_Peaks);title('Distance transform peaks');
cc = bwconncomp(D_Peaks, 8);
num_bubbles = cc.NumObjects

pause;
close all;