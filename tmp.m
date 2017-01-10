
clear;clc;close all;
%% 测试
url='e:/yezi/eye/0001.jpg';
I = imread(url);  
I2 = rgb2hsv(I);
I2H = I2(:,:,1);
I2S = I2(:,:,2);
I2V = I2(:,:,3);
I2V = im2double(I2V);
I2G=rgb2gray(I);
I3=edge(I2G,'roberts');%边缘检测
se1=strel('disk',16,8);%圆形闭环算子
I4=imclose(I3,se1);%闭环运算 需要选择大的算子

avg = mean(I2V(:));

%  I2V(I2V>=avg) =1;
%  I2V(I2V<avg) = 0;

%% 显示
figure(1);
subplot(221),imshow(I2);
subplot(222),imshow(I3);
subplot(223),imshow(I4);
subplot(224),imshow(I2S);

