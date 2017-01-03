i = imread('E:\yezi\eye2\0027.jpg');
w=size(i,2);
l=size(i,1);
disp(strcat('w��',num2str(w)));
disp(strcat('l��',num2str(l)));
left = imcrop(i,[0,0,w/2,l]);
leftRatio = sum(~left(:))/numel(left);
disp(strcat('leftRatio��',num2str(leftRatio)));
right = imcrop(i,[w/2,0,w/2,l]);
rightRatio = sum(~right(:))/numel(right);
disp(strcat('rightRatio��',num2str(rightRatio)));
if(rightRatio<leftRatio)
    disp('����');
else
    disp('����');
end;
subplot(3,1,1);
imshow(i);
subplot(3,1,2);
imshow(left);
subplot(3,1,3);
imshow(right);

