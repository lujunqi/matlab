%% ����ʶ��
clc
clear
close all
 filename=FileName();
 I=imread(filename);
subplot(3,2,1);
imshow(I),
title('ԭʼͼ��');
I_gray=rgb2gray(I);
subplot(3,2,2),imshow(I_gray),title('�Ҷ�ͼ��');
%% ======================   ��̬ѧԤ���� ======================
I_edge=edge(I_gray,'roberts');
subplot(3,2,3),imshow(I_edge),title('��Ե����ͼ��');
se=[1;1;1];
I_erode=imerode(I_edge,se);
subplot(3,2,4),imshow(I_erode),title('��ʴ���Եͼ��');
se=strel('rectangle',[25,25]);
I_close=imclose(I_erode,se);
%ͼ��պϡ����ͼ��
subplot(3,2,5),imshow(I_close),title('����ͼ��');
I_final=bwareaopen(I_close,1500);
%ȥ�����ŻҶ�ֵС��2000�Ĳ���
subplot(3,2,6),imshow(I_final),title('��̬�˲���ͼ��');
% figure,imshow(I_final),title('��̬�˲���ͼ��')
%% ==========================  ������ע    =============================
img_reg = regionprops(I_final,  'area', 'boundingbox');
areas = [img_reg.Area];
rects = cat(1,  img_reg.BoundingBox);



for i = 1:size(rects, 1)
    rectangle('position', rects(i, :), 'EdgeColor', 'r');
    i2=imcrop(I_final,rects(i,:));

end
%% ͼƬ��λ
I_new=zeros(size(I_final,1),size(I_final,2));
location_of_1=[];  for i=1:size(I_final,1)
    %Ѱ�Ҷ�ֵͼ���а׵ĵ��λ��
    for j=1:size(I_final,2)
        if I_final(i,j)==1;
            newlocation=[i,j];
            location_of_1=[location_of_1;newlocation];
        end
    end
end
mini=inf;maxi=0;
for i=1:size(location_of_1,1)
    %Ѱ�����а׵��У�x������y����ĺ������С���������λ��
    temp=location_of_1(i,1)+location_of_1(i,2);
    if temp<mini
        mini=temp;
        a=i;
    end
    if temp>maxi
        maxi=temp;
        b=i;
    end
end
first_point=location_of_1(a,:);
%����С�ĵ�Ϊ���Ƶ����Ͻ�
last_point=location_of_1(b,:);
%�����ĵ�Ϊ���Ƶ����½�
x1=first_point(1)+4;

%����ֵ����
x2=last_point(1)-4;
y1=first_point(2)+4;
y2=last_point(2)-4;

I_plate=I(x1:x2,y1:y2);
level = graythresh(I_plate);
I_plate=im2bw(I_plate,level);
figure, imshow(I_plate,[]);
% I_plate=OTSU(I_plate);
level = Otsu(I_plate);
I_plate=im2bw(I_plate,level);

%��OTSU�㷨�Էָ���ĳ��ƽ�������Ӧ��ֵ������
I_plate=bwareaopen(I_plate,50);
figure,imshow(I_plate),title('������ȡ')          %�������ճ���