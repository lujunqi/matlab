%% 车牌处理 形态+颜色（蓝牌）
clear;clc;close all;
%% 图片特征
filename = 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1483954057230&di=e5bb119b8ad4b5b626d96eea959d5eea&imgtype=0&src=http%3A%2F%2Fimg.qc188.com%2Foledit%2Fuploadfile%2F2013%2F03%2F26%2F20130326200438992.jpg';

I=imread(filename);%调用自编函数读取图像，并转化为灰度图象；

figure;
i1=rgb2gray(I);%灰度化
i2=edge(i1,'roberts');%边缘检测
% i2=edge(i1,'canny');%边缘检测
subplot(2,2,1), imshow(i2),title('边缘');
se=[1;1;1];%列腐蚀算子，腐蚀算子的形状很重要
i3=imerode(i2,se);%此腐蚀可将非车牌区域的噪声信息腐蚀掉
subplot(2,2,2),imshow(i3),title('腐蚀');
se1=strel('rectangle',[25,25]);%方形闭环算子
i4=imclose(i3,se1);%闭环运算 需要选择大的算子
subplot(2,2,3),imshow(i4),title('闭环');
i5=bwareaopen(i4,1500);%将连通域面积小于1500像素的区域都删除，此方法是为了把除车牌以外的区域都删除
subplot(2,2,4),imshow(i5),title('去噪声');
%% 特征位置标记
img_reg = regionprops(i5,  'area', 'boundingbox');
areas = [img_reg.Area];
rects = cat(1,img_reg.BoundingBox);
Image=im2double(I);

I2 = rgb2hsv(I);

%% 根据颜色提取 显示
figure;
subplot(221),imshow(I);
subplot(222),imshow(I2);
subplot(223),imshow(rgb2hsv(Image));
pec = [];
for i = 1:size(rects, 1)
    I5_1=imcrop(I2,rects(i,:));
    pec(i) = Func_PerColor(I5_1);
    
    subplot(2,size(rects, 1),i),imshow(I5_1),title(i);
    
end;
[ma,K]=max(pec);
target_I = imcrop(i2,rects(K,:));
%% 倾斜矫正
[H,T,R]=hough(target_I);
P=houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));

%得到线段信息
lines=houghlines(target_I,T,R,P,'FillGap',50,'MinLength',7);

subplot(224),imshow(target_I);
imwrite(target_I,'e:\yezi\1229.jpg');
