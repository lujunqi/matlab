%% ���ƴ��� ����
clear;clc;close all
%% ͼƬ����
filename = FileName();

I=imread(filename);%�����Աຯ����ȡͼ�񣬲�ת��Ϊ�Ҷ�ͼ��
tic;
imshow(I);
figure;
i1=rgb2gray(I);%�ҶȻ�
i2=edge(i1,'roberts');%��Ե���
% i2=edge(i1,'canny');%��Ե���
imwrite(i2,'e:\yezi\1229.jpg');
subplot(2,2,1), imshow(i2),title('��Ե');
se=[1;1;1];%�и�ʴ���ӣ���ʴ���ӵ���״����Ҫ
i3=imerode(i2,se);%�˸�ʴ�ɽ��ǳ��������������Ϣ��ʴ��
subplot(2,2,2),imshow(i3),title('��ʴ');
se1=strel('rectangle',[25,25]);%���αջ�����
i4=imclose(i3,se1);%�ջ����� ��Ҫѡ��������
subplot(2,2,3),imshow(i4),title('�ջ�');
i5=bwareaopen(i4,1500);%����ͨ�����С��1500���ص�����ɾ�����˷�����Ϊ�˰ѳ��������������ɾ��
subplot(2,2,4),imshow(i5),title('ȥ����');
%% ������ע
img_reg = regionprops(i5,  'area', 'boundingbox');
areas = [img_reg.Area];
rects = cat(1,  img_reg.BoundingBox);
%figure;

for i = 1:size(rects, 1)
    rectangle('position', rects(i, :), 'EdgeColor', 'r');
    i5_1=imcrop(I,rects(i,:));
    %subplot(1,size(rects, 1),i);
    %imshow(i5_1);
end;
toc;
%% ͼƬ��λ
[y,x,z]=size(i5);
i6=double(i5);
Y1=zeros(y,1);
for ii=1:y%ͳ��ÿһ�е�����ֵΪ1�ĸ���
    for jj=1:x
        if(i6(ii,jj,1)==1)
            Y1(ii,1)=Y1(ii,1)+1;
        end
    end
end
[temp,MaxY]=max(Y1);%tempΪY1�����ֵ��MaxYΪ�����ڵ�����
% figure,plot(1:y,Y1);
PY1=MaxY;
while((Y1(PY1,1)>=50)&&(PY1>1))%�����ϱ߽�
    PY1=PY1-1;
end
PY2=MaxY;
while((Y1(PY2,1)>=50)&&(PY2<y))%�����±߽�
    PY2=PY2+1;
end

X1=zeros(1,x);
for jj=1:x%ͳ��ÿһ�е�����ֵΪ1�ĸ�����ֻͳ�Ƴ������±߽�֮���������
    for ii=PY1:PY2
        if(i6(ii,jj,1)==1)
            X1(1,jj)=X1(1,jj)+1;
        end
    end
end
% figure,plot(1:x,X1);

PX1=1;
while((X1(1,PX1)<15)&&(PX1<x))%������߽�
    PX1=PX1+1;
end
PX2=x;
while((X1(1,PX2)<15)&&(PX2>PX1))%�����ұ߽�
    PX2=PX2-1;
end
PX1=PX1+1;
PX2=PX2-1;
% PY1=PY1-5;
% PY2=PY2+5;

dw=I(PY1:PY2,PX1:PX2,:);%��ó�������
%% ���Ʒָ�
figure;
I1=rgb2gray(dw);
subplot(2,2,1),imshow(dw),title('ԭͼ');

% 1/3�ָ�
g_max = double(max(max(I1)));
g_min = double(min(min(I1)));
T=round(g_max-(g_max-g_min)/3);
[m,n]=size(I1);
I1=im2bw(I1,T/256);

%����㷨 ��ֵ
% level = Otsu(I1);
% I1=im2bw(I1,level);

subplot(2,2,2),imshow(I1),title('��ֵ��');
I2=bwareaopen(I1,30);

subplot(2,2,3),imshow(I2),title('��̬ѧ�˲���Ķ�ֵ��ͼ��');

%% ����ʶ��
% ocrResults = ocr(I2);
% recognizedText = ocrResults.Text;
% disp('[');
% disp(recognizedText);
% disp(']');