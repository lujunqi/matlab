i = imread('E:\yezi\eye2\0027.jpg');
w=size(i,2);
l=size(i,1);
disp(strcat('w£º',num2str(w)));
disp(strcat('l£º',num2str(l)));
left = imcrop(i,[0,0,w/2,l]);
leftRatio = sum(~left(:))/numel(left);
disp(strcat('leftRatio£º',num2str(leftRatio)));
right = imcrop(i,[w/2,0,w/2,l]);
rightRatio = sum(~right(:))/numel(right);
disp(strcat('rightRatio£º',num2str(rightRatio)));
if(rightRatio<leftRatio)
    disp('ÓÒÑÛ');
else
    disp('×óÑÛ');
end;
subplot(3,1,1);
imshow(i);
subplot(3,1,2);
imshow(left);
subplot(3,1,3);
imshow(right);

