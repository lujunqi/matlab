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
    V = hsv(:,:,3); % 亮度
    mx = max(max(V));
    mn = min(min(V));
    me = mean(V(:)); %全部平均
    disp (strcat(fileName,'亮度最大：[',num2str(mx),'] 最小：[',num2str(mn),'] 平均：[',num2str(me),']'));% 最大亮度

end;

% subplot(1,1,1);
% imhist(V);