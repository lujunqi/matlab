close all; 
clear all; 
clc; 

businessCard = imread('e:/yezi/3.jpg'); 
% se1=strel('disk',1);%�����Ǵ���һ���뾶Ϊ5��ƽ̹��Բ�̽ṹԪ��
% businessCard=imerode(businessCard,se1);
ocrResults = ocr(businessCard); 
recognizedText = ocrResults.Text; 
disp(recognizedText);
figure; 
imshow(businessCard); 
%text(600,150,recognizedText,'BackgroundColor',[1,1,1]); 
title(strcat('ʶ������',recognizedText)); 
% 
% businessCard = imread('e:/yezi/ocr.jpg'); 
% ocrResults = ocr(businessCard,'CharacterSet','0 1 2 3 4 5 6 7 8 9'); 
% recognizedText = ocrResults.Text; 
% figure; 
% imshow(businessCard); 
% text(600,150,recognizedText,'BackgroundColor',[1,1,1]); 
% title('ʶ������'); 
% 
% businessCard = imread('e:/yezi/ocr.jpg'); 
% ocrResults = ocr(businessCard,'CharacterSet','0 1 2 3 4 5 6 7 8 9'); 
% recognizedText = ocrResults.Text; 
% figure; 
% imshow(businessCard); 
% text(600,150,recognizedText,'BackgroundColor',[1,1,1]); 
% title('ʶ������'); 