clear;
close all;
image = imread('e:\yezi\eye\1.png');
imager = image(:,:,1);
imageg = image(:,:,2);
imageb = image(:,:,3);
subplot(221);
imshow(imager);
title('r')
subplot(222);
imshow(imageg);
title('g')
subplot(223);
imshow(imageb);
title('b')
subplot(224);
imshow(image);