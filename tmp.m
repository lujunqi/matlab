clear;clc;close all;
%% plot 测试
url='e:/yezi/2.jpg';
I = imread(url);  
I1=rgb2gray(I);%灰度化
I2=im2bw(I1,0.5);% 二值化
figure;

y = sum(I2,1);
subplot(511),plot(y),title('y1二值化');
y2 = im2bw(y,0.5);
subplot(512),bar(y2),title('y2二值化');
x = sum(I2,2);
subplot(513),plot(x),title('x1二值化');
x(x<mean(x))=0;
x(x>=mean(x))=1;

x2 = im2bw(x,0.5);
subplot(514),bar(x2),title('x2二值化');
subplot(515),imshow(I2),title('原图');
