%% ���̶�λ
clear;clc;close all;
%% ����
url='e:/yezi/eye/0002.jpg';
I = imread(url);
I2 = rgb2hsv(I);
I2H = I2(:,:,1);
I2S = I2(:,:,2);
I2V = I2(:,:,3); %����
I2V = im2double(I2V);
% I2G=rgb2gray(I2V);
I3=edge(I2V,'roberts');%��Ե���
se1=strel('disk',16,8);%Բ�αջ�����
% se1=strel('rectangle',[25,25]);%���αջ�����
I4=imclose(I3,se1);%�ջ����� ��Ҫѡ��������




%% ��ʾ
figure(1);
subplot(221),imshow(I2);
subplot(222),imshow(I3);
subplot(223),imshow(I4);
subplot(224),imshow(I2V);

figure(2);

%% ѡ������

imshow(I4);
hold on;
line(rectx,recty);

% for i = 1:size(rects)
%     [x,y] = rects(i);
%     plot(x,y,'r+')
% %     subplot(2,size(rects, 1),i),imshow(I5_1),title(i);
%     
% end;
hold off;