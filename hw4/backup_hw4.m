echo on
%Problem 1
echo off


% Read and display the red image of mandrill.jpg
mandrill_raw=imread('mandrill.jpg'); 
figure; imagesc(mandrill_raw); title('Mandrill');axis image; pause;
% Convert rgb to hsv
h=rgb2hsv(mandrill_raw); v=h(:,:,3); 
[v1,v2] = size(v);
figure; imagesc(v); colormap(gray); axis image; colorbar;
title('Mandrill luminance (value)'); pause;

%Design low pass filter to blur the image
f_lp = [0 0.25 0.4 1];
a_lp = [1 1.0 0.0 0];
figure; plot(f_lp,a_lp); title('Low Pass Spatial Blur');
b = firpm(30 ,f_lp,a_lp);
mask = ftrans2(b);
%Apply the low pass blur
mandrill_lp = conv2(v,mask);
%mandrill_lp = abs(zerophase(ifft2(fft2(v, v1, v2).*fft2(mask, v1, v2))));
[s1,s2]= size(mandrill_lp);

figure; imagesc(mandrill_lp);title('Blurred mandrill')
pause;
f1=figure; imagesc(mandrill_lp);title('Grayscale blurred manrill');colormap(f1,gray);
pause;
%Apply AWG noise to the image
noise_sigma = 0.1;
noise = noise_sigma.*randn(s1,s2);
mandrill_noise = mandrill_lp + noise;
f2=figure; imagesc(mandrill_noise);title('Grayscale noised blurred mandrill');colormap(f2,gray);
pause;
%Remove extra pixels
mandrill_trunc = mandrill_noise(round((s1-v1)/2):end-round((s1-v1)/2)-1, round((s2-v2)/2):end-round((s2-v2)/2)-1);
f3=figure; imagesc(mandrill_trunc);title('Truncated mandrill');colormap(f3,gray);
pause;
%Generate and apply the Wiener filter
%H1=(fftshift(fft2(mask,s1,s2)));
%H1=H1(round((s1-v1)/2):end-round((s1-v)/2)-1, round((s2-v2)/2):end-round((s2-v2)/2)-1);
input_image = fftshift(fft2(mandrill_trunc));
Su = (v1*v2*(noise_sigma^2));
Sf = abs(fftshift(fft2(v)).^2);
H=fft2(mask,v1,v2);
mag = abs(fftshift(H.^2));
W = (((mag./(mag+(Su./Sf))))./abs(fftshift(H)));   %When this is just ./fftshift(H) instead of ./abs(fftshift(H)) we get non zero phase. Why??
%W = (((mag./(mag+(Su./Sf)))));
%W = fftshift(W);
out = (abs((ifft2(fftshift(W.*input_image)))));
f4=figure; imagesc((out)); title('Output'); colormap(f4,gray);
pause;



close all;