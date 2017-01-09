%% 霍夫转变 安利
clear;clc;close all;
I=imread('e:/yezi/c1.jpg');

I2=rgb2gray(I);
bw=im2bw(I,graythresh(I2));
bw=double(bw);
Iedge=edge(bw,'canny');    %边沿检测


%新建窗口，绘图用
figure (2)
imshow(Iedge);
hold on

%%左方直线检测与绘制
%得到霍夫空间
[H,T,R]=hough(Iedge);
%求极值点
P=houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));

%得到线段信息
lines=houghlines(Iedge,T,R,P,'FillGap',50,'MinLength',7);
max_len = 0;
for k=1:length(lines)
    xy=[lines(k).point1;lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',1);
    len=norm(lines(k).point1-lines(k).point2);
    Len(k)=len;
    if (len>max_len)
        max_len=len;
        xy_long=xy;
    end
end
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');
[L1 Index1]=max(Len(:));
x1=[lines(Index1).point1(1) lines(Index1).point2(1)];
y1=[lines(Index1).point1(2) lines(Index1).point2(2)];
% 求得线段的斜率
K1=-(lines(Index1).point1(2)-lines(Index1).point2(2))/...
    (lines(Index1).point1(1)-lines(Index1).point2(1))
hold off
angle=atan(K1)*180/pi
A = imrotate(I,-angle,'bilinear');% imrate 是逆时针的所以取一个负号
figure,imshow(A);