%% 视盘定位
clear;clc;close all;
%% 测试
url='e:/yezi/eye/0002.jpg';
I = imread(url);
I2 = rgb2hsv(I);
I2H = I2(:,:,1);
I2S = I2(:,:,2);
I2V = I2(:,:,3); %亮度
I2V = im2double(I2V);
% I2G=rgb2gray(I2V);
I3=edge(I2V,'roberts');%边缘检测
se1=strel('disk',16,8);%圆形闭环算子
% se1=strel('rectangle',[25,25]);%方形闭环算子
I4=imclose(I3,se1);%闭环运算 需要选择大的算子




%% 显示
figure(1);
subplot(221),imshow(I2);
subplot(222),imshow(I3);
subplot(223),imshow(I4);
subplot(224),imshow(I2V);

figure(2);

%% 选择视盘

imshow(I4);
hold on;
line(rectx,recty);

% for i = 1:size(rects)
%     [x,y] = rects(i);
%     plot(x,y,'r+')
% %     subplot(2,size(rects, 1),i),imshow(I5_1),title(i);
%     
% end;
hold off;