%% ���ƴ��� ��̬+��ɫ�����ƣ�
clear;clc;close all;
%% ͼƬ����
filename = FileName();

I=imread(filename);%�����Աຯ����ȡͼ�񣬲�ת��Ϊ�Ҷ�ͼ��

figure;
i1=rgb2gray(I);%�ҶȻ�
i2=edge(i1,'roberts');%��Ե���
% i2=edge(i1,'canny');%��Ե���
subplot(2,2,1), imshow(i2),title('��Ե');
se=[1;1;1];%�и�ʴ���ӣ���ʴ���ӵ���״����Ҫ
i3=imerode(i2,se);%�˸�ʴ�ɽ��ǳ��������������Ϣ��ʴ��
subplot(2,2,2),imshow(i3),title('��ʴ');
se1=strel('rectangle',[25,25]);%���αջ�����
i4=imclose(i3,se1);%�ջ����� ��Ҫѡ��������
subplot(2,2,3),imshow(i4),title('�ջ�');
i5=bwareaopen(i4,1500);%����ͨ�����С��1500���ص�����ɾ�����˷�����Ϊ�˰ѳ��������������ɾ��
subplot(2,2,4),imshow(i5),title('ȥ����');
%% ����λ�ñ��
img_reg = regionprops(i5,  'area', 'boundingbox');
areas = [img_reg.Area];
rects = cat(1,img_reg.BoundingBox);
Image=im2double(I);

I2 = rgb2hsv(I);

%% ������ɫ��ȡ ��ʾ
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

subplot(224),imshow(i2),title('Ŀ��');

%% ��б����
I47=edge(i1,'canny');%��Ե���


[H,T,R]=hough(I47);
P=houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));

%�õ��߶���Ϣ
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
% ����߶ε�б��
K1=-(lines(Index1).point1(2)-lines(Index1).point2(2))/...
    (lines(Index1).point1(1)-lines(Index1).point2(1))
angle=atan(K1)*180/pi;
target_I = imcrop(I,rects(K,:));


A = imrotate(target_I,-angle,'bilinear');% imrate ����ʱ�������ȡһ������

%% �˳���ɫ �ַ��ָ�
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
                (vij>=p(5)&&vij<=p(6))  % ��ɫ
            A3(i,j) = 1;
        end
    end
end
%% ���
figure;
subplot(221),imshow(A);

subplot(222),imshow(A3);


