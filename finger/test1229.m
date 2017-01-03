
clear;clc;close all;

f = imread('e:/yezi/1229.jpg');%读入图像

gf1 = fspecial('gaussian',3,15);%平滑处理
g = imfilter(double(f), gf1, 'replicate');
gf2 = fspecial('gaussian',4,9);
g = imfilter(g, gf2, 'replicate');
T = min(g(:));
gg=(g<=T+55);%二值化图像，并作图
figure,imshow(gg);

s= bwmorph(gg, 'skel', Inf);%提取骨骼
s1 = bwmorph(s, 'spur', 8);%删除毛刺
figure,imshow(s1);%显示骨骼图

h=Cpoint(s1);%特征点提取

[rt,ct]=find(h==6);%统计分叉点位置，并作图
ht=(h==6);
figure,imshow(ht);

