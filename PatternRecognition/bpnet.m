function y = bpnet( data )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global bpnet;
load bpnet.mat bpnet;
clc;
a = sim(bpnet,data');
a = round(a);
b = num2str(a);
c = bin2dec(b');
y = c-1;
end

