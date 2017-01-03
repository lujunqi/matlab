% 眼底血管图 可用

f=imread('e:\yezi\0077.jpg');
f=rgb2gray(f);
figure,imshow(f,[]);
title('视网膜眼底图像灰度图像');
f=double(f);


%参数设置
os=12;%检测方向个数
tim=3;%用于截断高斯曲线
L=9;%先将血管想象成一小段一小段的平行区域的组合，设定长度为L
T=40;%阈值选择


step = [1 1.5 2 3 3.5 4];
%尺度循环，选取尺度
for is = 1:6
    sigma = step(is);
    
    thetas=0:(os-1);%取0到11
    thetas=thetas.*(180/os);%.*表示两相同维度的矩阵对应元素相乘
    %表示每次相对于起始位置旋转的角度
    N1=-tim*sigma:tim*sigma;%用±3sigma截断高斯曲线
    N1=-exp(-(N1.^2)/2*sigma*sigma);%N1的每个元素的2次幂
    N=repmat(N1,[2*floor(L/2)+1,1]);%由N1组成的（2*floor（L/2）+1）X1的矩阵
    RNs=cell(1,os);
    MFRs=cell(1,os);
    
    
    %匹配滤波器，方向循环
    for i=1:os %从1到os的元素
        theta=thetas(i);
        RN=imrotate(N,theta);%将图像N绕中心点旋转theta角度
        %去除多余的0行0列
        RN=RN(:,any(RN));%any函数用于判断是否非零
        RN=RN(any(RN'),:);%'表示转置
        meanN=mean2(RN);%mean2(RN)相当于 mean(mean(RN)),mean(a)默认求各列均值
        RN=RN-meanN;
        RNs{1,i}=RN;
        MFRs{1,i}=imfilter(f,RN,'conv','symmetric');
    end
    
    
    %获取最大响应
    g=MFRs{1,1};
    for j=2:os
        g=max(g,MFRs{1,j});
    end
    
    
    figure,imshow(g,[]);
    title('匹配滤波后的图像');
    
    
end