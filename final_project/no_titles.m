rgb = imread('original.png'); %load image
rgb2 = rgb2gray(rgb); %change it to gray
rgb2 = imcomplement(rgb2); %invert the color
rgb2 = adapthisteq(rgb2, 'ClipLimit', 0.1); %enhance contract
BWdfill = imfill(im2bw(rgb2), 'holes'); %fill holes 
BWnobord = imclearborder(BWdfill, 4); %remove the boundary cells
rgb_perim = bwperim(im2bw(BWnobord)); %find the boundary
%overlay1 = imoverlay(rgb2gray(rgb),rgb_perim, [.3 1 .3]); %overlap figure with boundary
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