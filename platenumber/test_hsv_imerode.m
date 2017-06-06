%% ���ƴ��� ��ɫ->��̬�����ƣ�
clear;clc;close all;
%% ͼƬ��������
filename = 'http://imgsrc.baidu.com/forum/w%3D580/sign=ed979cd1d409b3deebbfe460fcbe6cd3/d0ea8694a4c27d1e69c2007d1ed5ad6edfc438f3.jpg';%FileName();

I=imread(filename);
I2 = rgb2hsv(I);

p=[0.56 0.71 0.4 1 0.3 1 0];

[y,x,z]=size(I2);
I3 = zeros(y,x);
for i = 1 : y
    for j = 1 : x
        hij = I2(i, j, 1);
        sij = I2(i, j, 2);
        vij = I2(i, j, 3);
        if (hij>=p(1) && hij<=p(2)) &&( sij >=p(3)&& sij<=p(4))&&...
                (vij>=p(5)&&vij<=p(6))  % ��ɫ
            I3(i,j) = 1;
        end
    end
end;
I4=edge(I3,'roberts');%��Ե���
I4=imerode(I4,[1;1;1]); %��ʴ
se1=strel('rectangle',[25,25]);%���αջ�����
I5=imclose(I4,se1);%�ջ����� ��Ҫѡ��������
%% ���
figure;
subplot(221),imshow(I2);
subplot(222),imshow(I3);
subplot(223),imshow(I4);
subplot(224),imshow(I5);
