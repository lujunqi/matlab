clc
clear ;
close all;
fileName = 'e:\yezi\eye\0632.jpg';
I = imread(fileName);
hsv = rgb2hsv(I);
V = hsv(:,:,3); % 亮度
mx = max(max(V));
mn = min(min(V));
me = mean(V(:)); %全部平均
disp (strcat(fileName,'亮度最大：[',num2str(mx),'] 最小：[',num2str(mn),'] 平均：[',num2str(me),']'));% 最大亮度
N = me;
% 所占百分比
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
V2=imerode(V2,se3);% 腐蚀
subplot(2,1,1);
imshow(V2);
subplot(2,1,2);
imshow(V);
