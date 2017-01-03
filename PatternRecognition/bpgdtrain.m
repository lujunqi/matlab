function bpgdtrain()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global bpnet;
clc;
load templet pattern;
c=0;
P=[];
for i=1:10
    for j=1:20
        c=c+1;
        P(:,c)=pattern(i).feature(:,j);
    end
end

T=zeros(4,200);
%0
T(4,1:20) = 1; 
%1
T(3,21:40) = 1;
%2
T(3:4,41:60) = 1;
%3
T(2,61:80) = 1;
%4
T(2,81:100) = 1;
T(4,81:100) = 1;
%5
T(2:3,101:120) = 1;
%6
T(2:4,121:140) = 1;
%7
T(1,141:160) = 1;
%8
T(1,161:180) = 1;
T(4,161:180) = 1;
%9
T(1,181:200) = 1;
T(3,181:200) = 1;

x = ones(25,2);
x(:,1)=0;
bpnet = newff(x,[50,4],{'logsig','logsig'},'traingd');
bpnet.trainParam.show = 50;
bpnet.trainParam.lr = 0.2;
bpnet.trainParam.epochs = 20000;
bpnet.trainParam.goal = 0.5e-1;
[bpnet]=train(bpnet,P,T);
%save bpnet.mat bpnet; %ÑµÁ·ºÃµÄÍøÂç
end

