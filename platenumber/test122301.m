%% 车牌识别
clc
clear
close all
 filename=FileName();
 I=imread(filename);
subplot(3,2,1);
imshow(I),
title('原始图像');
I_gray=rgb2gray(I);
subplot(3,2,2),imshow(I_gray),title('灰度图像');
%% ======================   形态学预处理 ======================
I_edge=edge(I_gray,'roberts');
subplot(3,2,3),imshow(I_edge),title('边缘检测后图像');
se=[1;1;1];
I_erode=imerode(I_edge,se);
subplot(3,2,4),imshow(I_erode),title('腐蚀后边缘图像');
se=strel('rectangle',[25,25]);
I_close=imclose(I_erode,se);
%图像闭合、填充图像
subplot(3,2,5),imshow(I_close),title('填充后图像');
I_final=bwareaopen(I_close,1500);
%去除聚团灰度值小于2000的部分
subplot(3,2,6),imshow(I_final),title('形态滤波后图像');
% figure,imshow(I_final),title('形态滤波后图像')
%% ==========================  特征标注    =============================
img_reg = regionprops(I_final,  'area', 'boundingbox');
areas = [img_reg.Area];
rects = cat(1,  img_reg.BoundingBox);



for i = 1:size(rects, 1)
    rectangle('position', rects(i, :), 'EdgeColor', 'r');
    i2=imcrop(I_final,rects(i,:));

end
%% 图片定位
I_new=zeros(size(I_final,1),size(I_final,2));
location_of_1=[];  for i=1:size(I_final,1)
    %寻找二值图像中白的点的位置
    for j=1:size(I_final,2)
        if I_final(i,j)==1;
            newlocation=[i,j];
            location_of_1=[location_of_1;newlocation];
        end
    end
end
mini=inf;maxi=0;
for i=1:size(location_of_1,1)
    %寻找所有白点中，x坐标与y坐标的和最大，最小的两个点的位置
    temp=location_of_1(i,1)+location_of_1(i,2);
    if temp<mini
        mini=temp;
        a=i;
    end
    if temp>maxi
        maxi=temp;
        b=i;
    end
end
first_point=location_of_1(a,:);
%和最小的点为车牌的左上角
last_point=location_of_1(b,:);
%和最大的点为车牌的右下角
x1=first_point(1)+4;

%坐标值修正
x2=last_point(1)-4;
y1=first_point(2)+4;
y2=last_point(2)-4;

I_plate=I(x1:x2,y1:y2);
level = graythresh(I_plate);
I_plate=im2bw(I_plate,level);
figure, imshow(I_plate,[]);
% I_plate=OTSU(I_plate);
level = Otsu(I_plate);
I_plate=im2bw(I_plate,level);

%以OTSU算法对分割出的车牌进行自适应二值化处理
I_plate=bwareaopen(I_plate,50);
figure,imshow(I_plate),title('车牌提取')          %画出最终车牌