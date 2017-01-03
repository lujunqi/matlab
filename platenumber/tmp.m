
clear;clc;close all;

Image=imread(FileName());
Image=im2double(Image);
s=size(Image,2)
I=rgb2hsv(Image);
[y,x,z]=size(I);
Blue_y = zeros(y, 1);
p=[0.56 0.71 0.4 1 0.3 1 0];
for i = 1 : y
    for j = 1 : x
        hij = I(i, j, 1);
        sij = I(i, j, 2);
        vij = I(i, j, 3);
        
        if (hij>=p(1) && hij<=p(2)) &&( sij >=p(3)&& sij<=p(4))&&...
                (vij>=p(5)&&vij<=p(6))
            Blue_y(i, 1) = Blue_y(i, 1) + 1;
        end
    end
end
[~, MaxY] = max(Blue_y);
Th = p(7);
PY1 = MaxY;
while ((Blue_y(PY1,1)>Th) && (PY1>0))
    PY1 = PY1 - 1;
end
PY2 = MaxY;
while ((Blue_y(PY2,1)>Th) && (PY2<y))
    PY2 = PY2 + 1;
end
PY1 = PY1 - 2;
PY2 = PY2 + 2;
if PY1 < 1
    PY1 = 1;
end
if PY2 > y
    PY2 = y;
end
It=Image(PY1:PY2,:,:);
subplot(231),imshow(It);
IY = I(PY1:PY2, :, :);
subplot(232),imshow(IY);
I2=im2bw(IY,0.5);
subplot(233),imshow(I2);

[y1,x1,z1]=size(IY);
Blue_x=zeros(1,x1);
for j = 1 : x1
    for i = 1 : y1
        hij = IY(i, j, 1);
        sij = IY(i, j, 2);
        vij = IY(i, j, 3);
        if (hij>=p(1) && hij<=p(2)) &&( sij >=p(3)&& sij<=p(4))&&...
                (vij>=p(5)&&vij<=p(6))
            Blue_x(1, j) = Blue_x(1, j) + 1;
            %              bw1(i, j) = 1;
        end
    end
end
PY1,PY2

[~, MaxX] = max(Blue_x);
Th = p(7);
PX1 = MaxX;

while ((Blue_x(1,PX1)>Th) && (PX1>0))
    PX1 = PX1 - 1;
end
PX2 = MaxX;
while ((Blue_x(1,PX2)>Th) && (PX2<x1))
    PX2 = PX2 + 1;
end
Ita=Image(PY1:PY2,PX1:PX2,:);
subplot(234),imshow(Ita),title('ԭͼ');
IX = I(PY1:PY2, PX1:PX2, :);
subplot(235),imshow(IX),title('hsv');
I2=im2bw(IX,0.5);
subplot(236),imshow(I2),title('��ֵ��');
%% ���Ʒָ�
figure;
B=[0 1 0
    1 1 1
    0 1 0];
I2=imdilate(I2,B);
I2=imdilate(I2,B);
I2=imdilate(I2,B);
img_reg = regionprops(I2,  'area', 'boundingbox');
areas = [img_reg.Area];
rects = cat(1,  img_reg.BoundingBox);
imshow(I2);
for i = 1:size(rects, 1)
    rectangle('position', rects(i, :), 'EdgeColor', 'r');
end
