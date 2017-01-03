close all; 
clear all; 
clc; 

businessCard = imread('e:/yezi/3.jpg'); 
% se1=strel('disk',1);%这里是创建一个半径为5的平坦型圆盘结构元素
% businessCard=imerode(businessCard,se1);
ocrResults = ocr(businessCard); 
recognizedText = ocrResults.Text; 
disp(recognizedText);
figure; 
imshow(businessCard); 
%text(600,150,recognizedText,'BackgroundColor',[1,1,1]); 
title(strcat('识别结果：',recognizedText)); 
% 
% businessCard = imread('e:/yezi/ocr.jpg'); 
% ocrResults = ocr(businessCard,'CharacterSet','0 1 2 3 4 5 6 7 8 9'); 
% recognizedText = ocrResults.Text; 
% figure; 
% imshow(businessCard); 
% text(600,150,recognizedText,'BackgroundColor',[1,1,1]); 
% title('识别数字'); 
% 
% businessCard = imread('e:/yezi/ocr.jpg'); 
% ocrResults = ocr(businessCard,'CharacterSet','0 1 2 3 4 5 6 7 8 9'); 
% recognizedText = ocrResults.Text; 
% figure; 
% imshow(businessCard); 
% text(600,150,recognizedText,'BackgroundColor',[1,1,1]); 
% title('识别数字'); 