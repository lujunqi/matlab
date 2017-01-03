% http://baike.baidu.com/link?url=Cxw7TyiNXahTtiveMbCHbghYNr5RTWOkCdTieU9hU8EQGHjSu-7_LguIWnMnibrpQ_L8qVUiS1SaCSdMe1hTQBCLa-onHFGxgqLxnRpcuk_
% regionprops(英文get the properties of region)是Matlab中用来度量图像区域属性的函数
clear,close all ;
src_img_name = 'e:\yezi\num.jpg';  
img = imread(src_img_name);  
  
% get binary image  
gray_img = rgb2gray(img);  
T = graythresh(gray_img);  
bw_img = im2bw(gray_img, T);  

% find the largest connected region  
img_reg = regionprops(bw_img,  'area', 'boundingbox');  
areas = [img_reg.Area];  
rects = cat(1,  img_reg.BoundingBox);  

% show all the largest connected region  

[~, max_id] = max(areas);  
max_rect = rects(max_id, :);  
 
% show the largest connected region  
figure(2),   
imshow(bw_img);  
rectangle('position', max_rect, 'EdgeColor', 'r');  