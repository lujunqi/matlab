%% 车牌处理 近景
clear;clc;close all
%% 图片特征
filename = FileName();

I=imread(filename);%调用自编函数读取图像，并转化为灰度图象；
tic;
imshow(I);
figure;
i1=rgb2gray(I);%灰度化
i2=edge(i1,'roberts');%边缘检测
% i2=edge(i1,'canny');%边缘检测
imwrite(i2,'e:\yezi\1229.jpg');
subplot(2,2,1), imshow(i2),title('边缘');
se=[1;1;1];%列腐蚀算子，腐蚀算子的形状很重要
i3=imerode(i2,se);%此腐蚀可将非车牌区域的噪声信息腐蚀掉
subplot(2,2,2),imshow(i3),title('腐蚀');
se1=strel('rectangle',[25,25]);%方形闭环算子
i4=imclose(i3,se1);%闭环运算 需要选择大的算子
subplot(2,2,3),imshow(i4),title('闭环');
i5=bwareaopen(i4,1500);%将连通域面积小于1500像素的区域都删除，此方法是为了把除车牌以外的区域都删除
subplot(2,2,4),imshow(i5),title('去噪声');
%% 特征标注
img_reg = regionprops(i5,  'area', 'boundingbox');
areas = [img_reg.Area];
rects = cat(1,  img_reg.BoundingBox);
%figure;

for i = 1:size(rects, 1)
    rectangle('position', rects(i, :), 'EdgeColor', 'r');
    i5_1=imcrop(I,rects(i,:));
    %subplot(1,size(rects, 1),i);
    %imshow(i5_1);
end;
toc;
%% 图片定位
[y,x,z]=size(i5);
i6=double(i5);
Y1=zeros(y,1);
for ii=1:y%统计每一行的像素值为1的个数
    for jj=1:x
        if(i6(ii,jj,1)==1)
            Y1(ii,1)=Y1(ii,1)+1;
        end
    end
end
[temp,MaxY]=max(Y1);%temp为Y1的最大值，MaxY为其所在的行数
% figure,plot(1:y,Y1);
PY1=MaxY;
while((Y1(PY1,1)>=50)&&(PY1>1))%求车牌上边界
    PY1=PY1-1;
end
PY2=MaxY;
while((Y1(PY2,1)>=50)&&(PY2<y))%求车牌下边界
    PY2=PY2+1;
end

X1=zeros(1,x);
for jj=1:x%统计每一列的像素值为1的个数，只统计车牌上下边界之间的像素数
    for ii=PY1:PY2
        if(i6(ii,jj,1)==1)
            X1(1,jj)=X1(1,jj)+1;
        end
    end
end
% figure,plot(1:x,X1);

PX1=1;
while((X1(1,PX1)<15)&&(PX1<x))%求车牌左边界
    PX1=PX1+1;
end
PX2=x;
while((X1(1,PX2)<15)&&(PX2>PX1))%求车牌右边界
    PX2=PX2-1;
end
PX1=PX1+1;
PX2=PX2-1;
% PY1=PY1-5;
% PY2=PY2+5;

dw=I(PY1:PY2,PX1:PX2,:);%求得车牌区域
%% 车牌分割
figure;
I1=rgb2gray(dw);
subplot(2,2,1),imshow(dw),title('原图');

% 1/3分割
g_max = double(max(max(I1)));
g_min = double(min(min(I1)));
T=round(g_max-(g_max-g_min)/3);
[m,n]=size(I1);
I1=im2bw(I1,T/256);

%大津算法 阈值
% level = Otsu(I1);
% I1=im2bw(I1,level);

subplot(2,2,2),imshow(I1),title('阈值化');
I2=bwareaopen(I1,30);

subplot(2,2,3),imshow(I2),title('形态学滤波后的二值化图像');

%% 车牌识别
% ocrResults = ocr(I2);
% recognizedText = ocrResults.Text;
% disp('[');
% disp(recognizedText);
% disp(']');