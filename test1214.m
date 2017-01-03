clc
clear ;
close all;
fileName = 'e:\yezi\eye\0632.jpg';
I = imread(fileName);
hsv = rgb2hsv(I);
V = hsv(:,:,3); % ����
mx = max(max(V));
mn = min(min(V));
me = mean(V(:)); %ȫ��ƽ��
disp (strcat(fileName,'�������[',num2str(mx),'] ��С��[',num2str(mn),'] ƽ����[',num2str(me),']'));% �������
N = me;
% ��ռ�ٷֱ�
threshold  = me;
V2 = V;
while(N>0.001 && threshold<mx)
    
    V2 = V;
    J=find(V2>=threshold );
    K=find(V2<threshold );
    V2(J) = 1;
    V2(K) = 0;
    
    N = numel(J)/numel(I);
    disp(threshold);
    threshold  = threshold+0.1;
end;

se3=strel('disk',10);
V2=imerode(V2,se3);% ��ʴ
subplot(2,1,1);
imshow(V2);
subplot(2,1,2);
imshow(V);
