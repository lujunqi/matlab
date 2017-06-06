%% 车牌处理 近景
clear;clc;close all
%% 图片特征
Files = dir(fullfile('E:\yezi\nj\','*.jpg'));

LengthFiles = length(Files);

%for i = 1:LengthFiles;
%     disp (strcat('E:\yezi\nj\',Files(i).name));
%     I=imread(strcat('E:\yezi\nj\',Files(i).name));%调用自编函数读取图像，并转化为灰度图象；
%I=imread('E:\yezi\nj\o_1bfomf7uhb81tef1u03ij81n8l6s.jpg');%调用自编函数读取图像，并转化为灰度图象；
I=imread('e:\yezi\1.jpg');
%I = imresize(I,0.3);
G = fspecial('gaussian', [5 5], 2);
Ig = imfilter(rgb2gray(I),G,'same');
I3=edge(Ig,'log');
imshow(I3);
figure;
I2=edge(rgb2gray(I),'log');
imshow(I2);

disp(var(I2(:)));
disp(var(I3(:)));

% disp(var(I3(:)));
% %end

hsv = rgb2hsv(I);
V = hsv(:,:,3); % 亮度
%disp(var(V(:)));
%C= contour(rgb2gray(I));
%bar(sum(V,2));
