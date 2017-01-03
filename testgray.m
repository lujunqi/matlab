path = 'E:\yezi\eye\';
path2 = 'E:\yezi\eye2\';

fileExt = '*.jpg';  
files = dir(fullfile(path,fileExt));  
len = size(files,1); 

% subplot;imshow(opticdisk);title('Input Image');



for i=1:len  
    fileName = strcat(path,files(i,1).name);
    fileName2 = strcat(path2,files(i,1).name);
    disp(fileName);
    
    I = imread(fileName);
    opticdisk = opticDisk(I,0.9);
    % ±£≥÷Õº∆¨
%     imwrite(opticdisk,fileName2); 
    
end;  
