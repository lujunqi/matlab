close all
clear all
clc
% ����ͼ������
img_name = input('������ͼ������(ͼ�����ΪRGBͼ������0����)��','s');
% ������0ʱ����
while ~strcmp(img_name,'0')
    % ��������ʶ��
    facedetection(img_name);
    img_name = input('������ͼ������(ͼ�����ΪRGBͼ������0����)��','s');
end