% 找边
I=imread( 'e:\yezi\44.jpg');
I=rgb2gray(I);               % 转化为灰色图像  
imshow(I);title('原图')  
BW1 = edge(I,'canny');  % 调用canny函数  
figure,imshow(BW1);     % 显示分割后的图像，即梯度图像  
title('matlab canny')  