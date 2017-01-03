function facedetection(img_name)
% ��ȡRGBͼ��
I = imread(img_name);
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
% ��ֵͼ����̬ѧ����
SE=strel('arbitrary',eye(5));  
%gray = bwmorph(gray,'erode');
% imopen�ȸ�ʴ������
gray = imopen(gray,SE);
% imclose�������ٸ�ʴ
%gray = imclose(gray,SE);
imshow(gray);
% ȡ��ͼƬ�����а�����ɫ�������С����
[L,num] = bwlabel(gray,8);
STATS = regionprops(L,'BoundingBox');
% ��ž���ɸѡ�Ժ�õ������о��ο�
n = 1;
result = zeros(n,4);
figure,imshow(I);
hold on;
for i = 1:num
	box = STATS(i).BoundingBox;
	x = box(1);	%��������x
	y = box(2);	%��������y
	w = box(3);	%���ο��w
	h = box(4);	%���θ߶�h
	% ��Ⱥ͸߶ȵı���
	ratio = h/w;
	ux = uint8(x);
	uy = uint8(y);
	if ux > 1
		ux = ux - 1;
	end
	if uy > 1
		uy = uy - 1;
	end
	% ��������������ľ���Ӧ��������������
	%   1���߶ȺͿ�ȱ��붼����20���Ҿ����������400
	%   2���߶ȺͿ�ȱ���Ӧ���ڷ�Χ��0.6,2����
	%   3������findeye����ֵΪ1
	if w < 20 || h < 20 || w*h < 400
		continue
	elseif ratio < 2 && ratio > 0.6 && findeye(gray,ux,uy,w,h) == 1
		% ��¼����Ϊ�����ľ�������
		result(n,:) = [ux uy w h];
		n = n+1;
	end
end
% �Կ�����������������б��
if  size(result,1) == 1 && result(1,1) > 0
	rectangle('Position',[result(1,1),result(1,2),result(1,3),result(1,4)],'EdgeColor','r');
else
	% ������������ľ����������1���ٸ���������Ϣ����ɸѡ
	for m = 1:size(result,1)
		m1 = result(m,1);
		m2 = result(m,2);
		m3 = result(m,3);
		m4 = result(m,4);
		% ������յ���������
		if m1 + m3 < width && m2 + m4 < heigth
			rectangle('Position',[m1,m2,m3,m4],'EdgeColor','r');
		end
	end
end