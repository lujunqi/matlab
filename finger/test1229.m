
clear;clc;close all;

f = imread('e:/yezi/1229.jpg');%����ͼ��

gf1 = fspecial('gaussian',3,15);%ƽ������
g = imfilter(double(f), gf1, 'replicate');
gf2 = fspecial('gaussian',4,9);
g = imfilter(g, gf2, 'replicate');
T = min(g(:));
gg=(g<=T+55);%��ֵ��ͼ�񣬲���ͼ
figure,imshow(gg);

s= bwmorph(gg, 'skel', Inf);%��ȡ����
s1 = bwmorph(s, 'spur', 8);%ɾ��ë��
figure,imshow(s1);%��ʾ����ͼ

h=Cpoint(s1);%��������ȡ

[rt,ct]=find(h==6);%ͳ�Ʒֲ��λ�ã�����ͼ
ht=(h==6);
figure,imshow(ht);

