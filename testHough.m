%% ����ת�� ����
clear;clc;close all;
I=imread('e:/yezi/c1.jpg');

I2=rgb2gray(I);
bw=im2bw(I,graythresh(I2));
bw=double(bw);
Iedge=edge(bw,'canny');    %���ؼ��


%�½����ڣ���ͼ��
figure (2)
imshow(Iedge);
hold on

%%��ֱ�߼�������
%�õ�����ռ�
[H,T,R]=hough(Iedge);
%��ֵ��
P=houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));

%�õ��߶���Ϣ
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
% ����߶ε�б��
K1=-(lines(Index1).point1(2)-lines(Index1).point2(2))/...
    (lines(Index1).point1(1)-lines(Index1).point2(1))
hold off
angle=atan(K1)*180/pi
A = imrotate(I,-angle,'bilinear');% imrate ����ʱ�������ȡһ������
figure,imshow(A);