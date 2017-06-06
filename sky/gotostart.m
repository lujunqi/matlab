img =imread('E:\yezi\sky\02-28-26-649.JPG');
   
  
% get binary image  
gray_img = rgb2gray(img);  
T = graythresh(gray_img);  
bw_img = im2bw(gray_img, T);  
  
% find the largest connected region  
img_reg = regionprops(bw_img,  'area', 'boundingbox');  
areas = [img_reg.Area];  
rects = cat(1,  img_reg.BoundingBox); 
figure(1),  
imshow(bw_img);  
for i = 1:size(rects, 1)  
    rectangle('position', rects(i, :), 'EdgeColor', 'r');  
end  