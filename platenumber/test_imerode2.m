%% ���ƴ��� ��̬+��ɫ�����ƣ�
clear;clc;close all;
%% ͼƬ����
filename = 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1483954057230&di=e5bb119b8ad4b5b626d96eea959d5eea&imgtype=0&src=http%3A%2F%2Fimg.qc188.com%2Foledit%2Fuploadfile%2F2013%2F03%2F26%2F20130326200438992.jpg';

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
%% ��б����
[H,T,R]=hough(target_I);
P=houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));

%�õ��߶���Ϣ
lines=houghlines(target_I,T,R,P,'FillGap',50,'MinLength',7);

subplot(224),imshow(target_I);
imwrite(target_I,'e:\yezi\1229.jpg');
