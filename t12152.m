close all 
clear 

I = imread('http://photocdn.sohu.com/20151004/mp34285789_1443952907757_7.jpeg');
% ת��Ϊ�Ҷ�ͼ��
gray = rgb2gray(I);
% ��ͼ��ת��ΪYCbCr��ɫ�ռ�
YCbCr = rgb2ycbcr(I);
% ���ͼ���Ⱥ͸߶�
heigth = size(gray,1);
width = size(gray,2);
% ���ݷ�ɫģ�ͽ�ͼ���ֵ��
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