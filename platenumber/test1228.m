%% ���ƴ��� Զ��
clear;clc;close all;
filename = FileName();
I = imread(filename);
tic;
I =  rgb2gray(I);%�ҶȻ�
figure(1);
subplot(2,2,1);
imshow(I);
se = strel('disk',20);
I_opened = imopen(I,se);
subplot(2,2,2);
imshow(I_opened,[])

Egray=imsubtract(I,I_opened);
subplot(2,2,3);
imshow(Egray);title('��ǿ�ڰ�ͼ��');

%i1=rgb2gray(Egray);%�ҶȻ�
i2=edge(Egray,'canny');%��Ե���
subplot(2,2,4), imshow(i2);

figure(2);
bg1=imclose(i2,strel('rectangle',[5,19]));
subplot(2,2,1),imshow(bg1);title('ͼ�������[5,19]');
bg3=imopen(bg1,strel('rectangle',[5,19]));
subplot(2,2,2),imshow(bg3);title('ͼ������[5,19]');
bg2=imopen(bg3,strel('rectangle',[19,1]));
subplot(2,2,3),imshow(bg2);title('ͼ������[19,1]');

%% ������ע
img_reg = regionprops(bg2,  'area', 'boundingbox');
areas = [img_reg.Area];
rects = cat(1,  img_reg.BoundingBox);
%figure;

for i = 1:size(rects, 1)
    rectangle('position', rects(i, :), 'EdgeColor', 'r');
    i5_1=imcrop(I,rects(i,:));
end;
toc;
% se=[1;1;1];%�и�ʴ���ӣ���ʴ���ӵ���״����Ҫ
% i3=imerode(i2,se);%�˸�ʴ�ɽ��ǳ��������������Ϣ��ʴ��
% subplot(2,2,1),imshow(i3);
% se1=strel('rectangle',[25,25]);%���αջ�����
% i4=imclose(i3,se1);%�ջ����� ��Ҫѡ��������
% subplot(2,2,2),imshow(i4);
% i5=bwareaopen(i4,1500);%����ͨ�����С��1500���ص�����ɾ�����˷�����Ϊ�˰ѳ��������������ɾ��
% subplot(2,2,3),imshow(i5)