path = 'E:\yezi\eye\';
path2 = 'E:\yezi\eye2\';

fileExt = '*.jpg';
files = dir(fullfile(path,fileExt));
len = size(files,1);

% subplot;imshow(opticdisk);title('Input Image');



for i=1:len
    fileName = strcat(path,files(i,1).name);
    I = imread(fileName);
    hsv = rgb2hsv(I);
    V = hsv(:,:,3); % ����
    mx = max(max(V));
    mn = min(min(V));
    me = mean(V(:)); %ȫ��ƽ��
    disp (strcat(fileName,'�������[',num2str(mx),'] ��С��[',num2str(mn),'] ƽ����[',num2str(me),']'));% �������

end;

% subplot(1,1,1);
% imhist(V);