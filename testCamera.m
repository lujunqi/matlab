%% ��ȡ����ͷ
clc; clear; close all;
vid = videoinput('winvideo', 1, 'YUY2_640x480');
set(vid,'ReturnedColorSpace','rgb');
vidRes=get(vid,'VideoResolution');
width=vidRes(1);
height=vidRes(2);
nBands=get(vid,'NumberOfBands');
figure('Name', 'Matlab��������ͷ By Lyqmath', 'NumberTitle', 'Off', 'ToolBar', 'None', 'MenuBar', 'None');
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
%% ͼ����


%% ��ʾ
preview(vid,hImage);