
clear;clc;close all;
%% ����
url='e:/yezi/eye/0001.jpg';
I = imread(url);  
I2 = rgb2hsv(I);
I2H = I2(:,:,1);
I2S = I2(:,:,2);
I2V = I2(:,:,3);
I2V = im2double(I2V);
I2G=rgb2gray(I);
I3=edge(I2G,'roberts');%��Ե���
se1=strel('disk',16,8);%Բ�αջ�����
I4=imclose(I3,se1);%�ջ����� ��Ҫѡ��������

avg = mean(I2V(:));

%  I2V(I2V>=avg) =1;
%  I2V(I2V<avg) = 0;

%% ��ʾ
figure(1);
subplot(221),imshow(I2);
subplot(222),imshow(I3);
subplot(223),imshow(I4);
subplot(224),imshow(I2S);

