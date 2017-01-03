%% 车牌处理 远景
clear;clc;close all;
filename = FileName();
I = imread(filename);
tic;
I =  rgb2gray(I);%灰度化
figure(1);
subplot(2,2,1);
imshow(I);
se = strel('disk',20);
I_opened = imopen(I,se);
subplot(2,2,2);
imshow(I_opened,[])

Egray=imsubtract(I,I_opened);
subplot(2,2,3);
imshow(Egray);title('增强黑白图像');

%i1=rgb2gray(Egray);%灰度化
i2=edge(Egray,'canny');%边缘检测
subplot(2,2,4), imshow(i2);

figure(2);
bg1=imclose(i2,strel('rectangle',[5,19]));
subplot(2,2,1),imshow(bg1);title('图像闭运算[5,19]');
bg3=imopen(bg1,strel('rectangle',[5,19]));
subplot(2,2,2),imshow(bg3);title('图像开运算[5,19]');
bg2=imopen(bg3,strel('rectangle',[19,1]));
subplot(2,2,3),imshow(bg2);title('图像开运算[19,1]');

%% 特征标注
img_reg = regionprops(bg2,  'area', 'boundingbox');
areas = [img_reg.Area];
rects = cat(1,  img_reg.BoundingBox);
%figure;

for i = 1:size(rects, 1)
    rectangle('position', rects(i, :), 'EdgeColor', 'r');
    i5_1=imcrop(I,rects(i,:));
end;
toc;
% se=[1;1;1];%列腐蚀算子，腐蚀算子的形状很重要
% i3=imerode(i2,se);%此腐蚀可将非车牌区域的噪声信息腐蚀掉
% subplot(2,2,1),imshow(i3);
% se1=strel('rectangle',[25,25]);%方形闭环算子
% i4=imclose(i3,se1);%闭环运算 需要选择大的算子
% subplot(2,2,2),imshow(i4);
% i5=bwareaopen(i4,1500);%将连通域面积小于1500像素的区域都删除，此方法是为了把除车牌以外的区域都删除
% subplot(2,2,3),imshow(i5)