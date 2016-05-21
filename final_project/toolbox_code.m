rgb = imread('FigP1127_bubbles-0.png'); %load image
f1=figure;figure(f1);imshow(rgb); title('Original image');
%rgb2 = rgb2gray(rgb); %change it to gray
%f2=figure;figure(f2);imshow(rgb2);title('Changed to grayscale');
rgb2 = imcomplement(rgb); %invert the color
f3=figure;figure(f3);imshow(rgb2);title('Inverted color');
rgb2 = adapthisteq(rgb2, 'ClipLimit', 0.1); %enhance contract
f4=figure;figure(f4);imshow(rgb2);title('Contrast enhanced'); 
BWdfill = imfill(im2bw(rgb2), 'holes'); %fill holes 
f5=figure;figure(f5);imshow(BWdfill);title('Fill holes'); 
BWnobord = imclearborder(BWdfill, 4); %remove the boundary cells
f6=figure;figure(f6);imshow(BWnobord);title('Remove boundary cells'); 
rgb_perim = bwperim(im2bw(BWnobord)); %find the boundary
f7=figure;figure(f7);imshow(rgb_perim);title('Find the boundary'); 
%overlay1 = imoverlay(rgb,rgb_perim, [.3 1 .3]); %overlap figure with boundary
%imshow(overlay1)
bw = BWnobord;
cc = bwconncomp(bw, 8);
graindata = regionprops(cc,'basic');
grain_areas = [graindata.Area];
length(grain_areas);
min(grain_areas);
max(grain_areas);
s = regionprops(BWnobord, {'Centroid'});
hold on
numObj = numel(s) %show the total number of cell
label_num = 0;
for k = 1 : numObj
    if (grain_areas(k)> 200) & ( grain_areas(k) < 4000) %set area range
    plot(s(k).Centroid(1), s(k).Centroid(2), 'ro'); %label selected ones
    label_num = label_num + 1; %count number
    end
end
hold off
label_num

pause;
close all;
clear;


D = bwdist(rgb);
DL = watershed(D);
bgm = DL == 0;
bw=bw-bgm;
imshow(bw);