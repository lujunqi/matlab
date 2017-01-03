% ÈËÁ³Ê¶±ð
close all;
clear;
FDetect = vision.CascadeObjectDetector();
I =  imread('E:\yezi\44.jpg');  
face_dtect = step(FDetect,I);
figure(1),  
imshow(I); hold on  
for i = 1:size(face_dtect,1)  
  %  disp(face_dtect);
    rectangle('Position',face_dtect(i,:),'LineWidth',1,'LineStyle','-','EdgeColor','m');  
end  
title('Face Detection');  
% hold off; 
I1=imcrop(I,face_dtect);

%%To detect Nose  
NoseDetect = vision.CascadeObjectDetector('RightEyeCART','MergeThreshold',16);  
% NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',16);  
face_dtect1=step(NoseDetect,I1);  
% figure(2),  
% imshow(I1); hold on  
for i = 1:size(face_dtect1,1)
    disp(i)
    face_dtect2 = face_dtect1(i,:) +[face_dtect(1,1) face_dtect(1,2) 0 0 ];
    rectangle('Position',face_dtect2(:),'LineWidth',1,'LineStyle','-','EdgeColor','m');  
end  
title('Nose Detection');  
hold off;  
  