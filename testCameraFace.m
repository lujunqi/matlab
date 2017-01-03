%% ªÒ»°…„œÒÕ∑
clc; clear; close all;
vid = videoinput('winvideo', 1, 'YUY2_640x480');
set(vid,'ReturnedColorSpace','rgb');
preview(vid);

while(1)
frame = getsnapshot(vid);
imshow(frame);
end