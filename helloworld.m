% ���ͼ��Ϊ BW������ͼ��Ϊf  
%optimize from main_optimize, merely select 2 lines, one has positive  
%slope,the other has negative slope  
clear,close all  
I=imread('e:\yezi\0077.jpg');  
imshow(I);title('ԭͼ');
J = rgb2gray(I);

BW1=edge(J,'canny'); 

figure,imshow(BW1); 
BW2=edge(J,'roberts');
figure,imshow(BW2);
