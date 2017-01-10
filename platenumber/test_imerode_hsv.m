%% 车牌处理 形态+颜色（蓝牌）
clear;clc;close all;
%% 图片特征
filename = FileName();

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
figure(2);
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

subplot(224),imshow(i2),title('目标');

%% 倾斜矫正
I47=edge(i1,'canny');%边缘检测


[H,T,R]=hough(I47);
P=houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));

%得到线段信息
lines=houghlines(I47,T,R,P,'FillGap',50,'MinLength',7);
max_len = 0;
for k=1:length(lines)
    xy=[lines(k).point1;lines(k).point2];
   % plot(xy(:,1),xy(:,2),'LineWidth',1);
    len=norm(lines(k).point1-lines(k).point2);
    Len(k)=len;
    if (len>max_len)
        max_len=len;
        xy_long=xy;
    end
end
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');
[L1 Index1]=max(Len(:));
x1=[lines(Index1).point1(1) lines(Index1).point2(1)];
y1=[lines(Index1).point1(2) lines(Index1).point2(2)];
% 求得线段的斜率
K1=-(lines(Index1).point1(2)-lines(Index1).point2(2))/...
    (lines(Index1).point1(1)-lines(Index1).point2(1))
angle=atan(K1)*180/pi;
target_I = imcrop(I,rects(K,:));


A = imrotate(target_I,-angle,'bilinear');% imrate 是逆时针的所以取一个负号

%% 滤出蓝色 字符分割
p=[0.56 0.71 0.4 1 0.3 1 0];
A2 = rgb2hsv(A);
[y,x,z]=size(A2);
A3 = zeros(y,x);

for i = 1 : y
    for j = 1 : x
        hij = A2(i, j, 1);
        sij = A2(i, j, 2);
        vij = A2(i, j, 3);
        if (hij>=p(1) && hij<=p(2)) &&( sij >=p(3)&& sij<=p(4))&&...
                (vij>=p(5)&&vij<=p(6))  % 蓝色
            A3(i,j) = 1;
        end
    end
end
%% 输出
figure;
subplot(221),imshow(A);

subplot(222),imshow(A3);


