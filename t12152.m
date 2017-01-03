close all 
clear 

I = imread('http://photocdn.sohu.com/20151004/mp34285789_1443952907757_7.jpeg');
% 转换为灰度图像
gray = rgb2gray(I);
% 将图像转化为YCbCr颜色空间
YCbCr = rgb2ycbcr(I);
% 获得图像宽度和高度
heigth = size(gray,1);
width = size(gray,2);
% 根据肤色模型将图像二值化
for i = 1:heigth
	for j = 1:width
		Y = YCbCr(i,j,1);
		Cb = YCbCr(i,j,2);
		Cr = YCbCr(i,j,3);
		if(Y < 80)
			gray(i,j) = 0;
		else
			if(skin(Y,Cb,Cr) == 1)
				gray(i,j) = 255;
			else
				gray(i,j) = 0;
			end
		end
	end
end