echo on
%Author: Leo Bremer
%ID #: 428819
%ESE588 Fall 2015
%Prof. Arthur
%
%Problem Statement: DESIGN a minimum-mean-square-error filter to restore the mandrill image
% after you have blurred it with a 2D version (your choice) of a 1D low-pass, zerophase
% filter of length 31 with a passband that ends at 0.25. Fully defend your
% choice for the start of the stop band. Document your rationale (be sure to be
% quantitative) for your choice of the width of the transition region. Add white
% noise, whose average spectral density is F that of the average value for the
% blurred image, to the blurred image, where 2F is the percentage given by the last
% two non-zero digits of your student ID number. Be sure to include the exact
% expression for your restoration filter. Calculate the RMS values of the error in the
% restored image. For what noise levels would you expect a Wiener filter to be
% useful? What effect did your choice of the beginning of the stop band have on
% your ability to recover the original image?
echo off

% Read and display mandrill.jpg
mandrill_raw=imread('mandrill.jpg'); 
figure; imagesc(mandrill_raw); title('Mandrill');axis image; pause;
% Convert rgb to hsv
h=rgb2hsv(mandrill_raw); v=h(:,:,3); 
[v1,v2] = size(v);
figure; imagesc(v); colormap(gray); axis image; colorbar;
title('Mandrill Luminance (value)'); pause;

%Design low pass filter to blur the image
echo on
% Use firpm to generate a 1-D low pass filter with length 31 and passband from 0 
% to 0.25. Once we are satisfied that the 1-D filter meets the design criteria,
% use ftrans2 to create a circularly symmetric 2-D filter from the 1-D 
% coefficients.
echo off
f_lp = [0 0.25 0.4 1];
a_lp = [1 1.0 0.0 0];
figure; plot(f_lp,a_lp); title('Low Pass Spatial Blur Design Specs');
b = firpm(30 ,f_lp,a_lp);
mask = ftrans2(b);
%Apply the low pass blur
echo on
%Apply the low pass blurring filter to the image using conv2.
echo off
mandrill_lp = conv2(v,mask);
[s1,s2]= size(mandrill_lp);

figure; imagesc(mandrill_lp);title('Blurred mandrill')
pause;
f1=figure; imagesc(mandrill_lp);title('Grayscale blurred manrill');colormap(f1,gray);
pause;
%Apply AWG noise to the image
echo on
% After blurring the image, we will further corrupt it with additive zero mean
% white Gaussian noise. Use randn to generate the AWGN. The last two digits 
% of my ID # are 19, so to meet the design specs the noise PSD should be 
% 9.5% of the original image's PSD. Since the noise is zero-mean,
% its PSD equals (#vertical pixels)*(#horizontal pixels)*sigma^2.
echo off
orig_PSD = abs(fftshift(fft2(v).^2));
avg_PSD = mean(reshape(orig_PSD, [], 1));
noise_sigma = sqrt((0.095*avg_PSD)/(v1*v2));
noise = noise_sigma.*randn(s1,s2);
mandrill_noise = mandrill_lp + noise;
f2=figure; imagesc(mandrill_noise);title('Grayscale noised blurred mandrill');colormap(f2,gray);
pause;
%Remove extra pixels
echo on
% When we blurred the mandrill with conv2, the circular convolution added some
% extra pixels on each dimension. Remove them so the image size matches the original
% image size.
echo off
mandrill_trunc = mandrill_noise(round((s1-v1)/2):end-round((s1-v1)/2)-1, round((s2-v2)/2):end-round((s2-v2)/2)-1);
f3=figure; imagesc(mandrill_trunc);title('Truncated mandrill');colormap(f3,gray);
pause;
%Generate and apply the Wiener filter
input_image = fftshift(fft2(mandrill_trunc));
Su = (v1*v2*(noise_sigma^2));
Sf = abs(fftshift(fft2(v)).^2);
H=fft2(mask,v1,v2);
mag = abs(fftshift(H.^2));
W = (((mag./(mag+(Su./Sf))))./abs(fftshift(H)));   
out = (abs((ifft2(fftshift(W.*input_image)))));
f4=figure; imagesc((out)); title('Output'); colormap(f4,gray);
echo on
%There is no pixel wrapping around the height or width, so the filter looks
%zero phase.
echo off
pause;



close all;