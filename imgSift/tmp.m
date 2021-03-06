ref= imread('e:/yezi/eye2/0001.jpg');  
book= imread('e:/yezi/eye2/0002.jpg');
% ref = imread('pout.tif');
H = fspecial('Gaussian',[11 11],1.5);
A = imfilter(ref,H,'replicate');

subplot(1,2,1); imshow(ref); title('Reference Image');
subplot(1,2,2); imshow(A);   title('Blurred Image');

[ssimval, ssimmap] = ssim(A,book);

fprintf('The SSIM value is %0.4f.\n',ssimval);

figure, imshow(ssimmap,[]);
title(sprintf('ssim Index Map - Mean ssim Value is %0.4f',ssimval));