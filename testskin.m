%Color Image --> Lighting Compensation --> Color Space Transformation  
%--> Skin Color Detection --> Variance-based Segmentation -->   
%Connected Component & Grouping --> Eye/Mouth Detection -->   
%Face Boundary Detection --> Verifying/Weighting Eyes-Mouth Triangles  
  
%%  ������ Ƥ��
%basic operation  
clc;  
clear all;  
close all;  
  
img = imread('e:/yezi/44.jpg');  
figure ;imshow(img);title('ԭʼͼ��');  
  
[row col dim] = size(img);  
img_double = double(img);  
  
%get RGB channel  
R = img_double(:,:,1);G = img_double(:,:,2);B = img_double(:,:,3);  
figure ;  
subplot(1,3,1);imshow(uint8(R));title('��ɫ����');  
subplot(1,3,2);imshow(uint8(G));title('��ɫ����');  
subplot(1,3,3);imshow(uint8(B));title('��ɫ����');  
  
%%  
%convert RGB space to YcbCr-color space  
R = double(R);G = double(G);B = double(B);  
H =[65.4810  128.5530   24.9660;  
    -37.7970  -74.2030  112.0000;  
    112.0000  -93.7860  -18.2140];  
% I = H/(sum(sum(H)));%���ճ�����о���Ĺ�һ��  
I = H/255;%��ɫ���ؿռ�ı�׼��һ��  
Ymax = 235;Ymin = 16;  
img_YCbCr(:,:,1) = I(1,1)*R+I(1,2)*G+I(1,3)*B+16;  
img_YCbCr(:,:,2) = I(2,1)*R+I(2,2)*G+I(2,3)*B+128;  
img_YCbCr(:,:,3) = I(3,1)*R+I(3,2)*G+I(3,3)*B+128;  
  
if(img_YCbCr(:,:,1) > Ymax)  
     img_YCbCr(:,:,1) = Ymax;  
elseif(img_YCbCr(:,:,1)<Ymin)  
        img_YCbCr(:,:,1)=Ymin;  
end  
if(img_YCbCr(:,:,2) > Ymax)  
     img_YCbCr(:,:,2) = Ymax;  
elseif(img_YCbCr(:,:,2)<Ymin)  
        img_YCbCr(:,:,2)=Ymin;  
end  
if(img_YCbCr(:,:,3) > Ymax)  
     img_YCbCr(:,:,3) = Ymax;  
elseif(img_YCbCr(:,:,3)<Ymin)  
        img_YCbCr(:,:,3)=Ymin;  
end  
  
%%  
%��YCbCrɫ�ʿռ�������ɫ��⣬��Բģ�ͼ��Cb��Cr  
y=img_YCbCr(:,:,1);  
Cx = 109.38;Cy = 152.02;theta = 2.53;  
ecx = 1.60;ecy = 2.41;a = 25.39;b = 14.03;  
img_bin = zeros(row,col);  
for i=1:row  
    for j=1:col  
        temp=cos(theta)*(img_YCbCr(i, j, 2) - Cx)+...  
            sin(theta)*(img_YCbCr(i, j, 3) - Cy);  
        y(i,j)=-sin(theta)*(img_YCbCr(i, j, 2) - Cx)+...  
            cos(theta)*(img_YCbCr(i, j, 3) - Cy);  
        lea = (temp - ecx).^2 / (a^2) + (y(i, j) - ecy).^2 / (b^2);  
        if(lea<=1)   %������Ϊ��ɫ�ĵ���Ϊ��ɫ  
            img_bin(i,j) = 255;  
        end  
        if(img_YCbCr(i,j,1) <= 80) %ȥ��ͼ����ɫ�ʺܰ��ĵ�  
            img_bin(i,j) = 0;  
        end  
    end  
end  
  
%%  
%show image  
img_YCbCr = uint8(img_YCbCr);  
figure ;imshow(img_YCbCr);title('YCBCRģ��');  
figure ;  
subplot(1,3,1);imshow(img_YCbCr(:,:,1));title('Y����');  
subplot(1,3,2);imshow(img_YCbCr(:,:,2));title('CB����');  
subplot(1,3,3);imshow(img_YCbCr(:,:,3));title('CR����');  
figure ;imshow(img_bin);title('�ָ�');  
  
%��3*3ģ��Զ�ֵͼ��������Ͳ���  
se = strel('diamond', 3);  
img_bin = imdilate(img_bin, se);  
figure ;  
subplot(3,2,1);imshow(img_bin);title('diamond-����');  
se = strel('square', 3);  
img_bin = imdilate(img_bin, se);  
subplot(3,2,2);imshow(img_bin);title('square-����');  
se = strel('pair', [1,1]);  
img_bin = imdilate(img_bin, se);  
subplot(3,2,3);imshow(img_bin);title('pair-����');  
se = strel('disk', 3);  
img_bin = imdilate(img_bin, se);  
subplot(3,2,4);imshow(img_bin);title('disk-����');  
se = strel('rectangle', [1,3]);  
img_bin = imdilate(img_bin, se);  
subplot(3,2,5);imshow(img_bin);title('rectangle-����');  
se = strel('octagon', 3);  
img_bin = imdilate(img_bin, se);  
subplot(3,2,6);imshow(img_bin);title('octagon-����');  