%{
工程名称：带色彩恢复的视网膜增强算法实现
修改日期：2015年11月13日10:40:24
修改思路：http://www.cnblogs.com/Imageshop/archive/2013/04/17/3026881.html
测试结果：
下一步方向：
参考论文：
归纳总结：
  （1）S=L*R
  这个地方我认为S是原始图像，范围0-255.L是入射光，范围也是0-255
  而反射光是一个系数，有S和L的值决定。
  （2）这个算法那在水下图像处理中，有时候会产生颜色失真。
  （3）尺度系数选择20 100 300
  （4）这个算法产生的噪声比CLAHE小一点。。CLAHE的噪声有时候难以忍受
%}
clc
clear all;
close all
%第一部分： 程序部分 
img=imread('e:/yezi/0077.jpg');% 修改成你的图像所在的地址
imgr=double(img(:,:,1));
imgg=double(img(:,:,2));
imgb=double(img(:,:,3));
mr=mat2gray(im2double(imgr)); 
mg=mat2gray(im2double(imgg)); 
mb=mat2gray(im2double(imgb));%数据类型归一化 
alf1=200; %定义标准差alf=a^2/2  a=20
n=351;%模板越大越好，161的时候好像效果不是很好
n1=floor((n+1)/2);%计算中心
for i=1:n
    for j=1:n
      b(i,j) =exp(-((i-n1)^2+(j-n1)^2)/(4*alf1))/(4*pi*alf1); %这个系数不知道有没有影响了
    end
end % 
sum1=sum(sum(b));%
b=b/sum1;% 归一化处理
nr1 = double(imfilter(imgr,b,'conv', 'replicate'));% 滤波器？？
ng1 = double(imfilter(imgg,b,'conv', 'replicate'));
nb1 = double(imfilter(imgb,b,'conv', 'replicate'));%卷积滤波
fil=cat(3,nr1,ng1,nb1);% 模糊结果
[h0,w0]=size(imgr); 
for i=1:h0
    for j=1:w0      
        % 通过循环进行控制
        if(imgr(i,j)==0)||(nr1(i,j)==0)
           % 这个地方透射率必然是0
           yr1(i,j)=0;
        else 
           yr1(i,j)=(log(imgr(i,j))-log(nr1(i,j)));% 这个地方计算的不准确啊。。。
        end        
        if(imgg(i,j)==0)||(ng1(i,j)==0)
           % 这个地方透射率必然是0
           yg1(i,j)=0;
        else 
           yg1(i,j)=(log(imgg(i,j))-log(ng1(i,j)));
        end        
        if(imgb(i,j)==0)||(nb1(i,j)==0)
           % 这个地方透射率必然是0
           yb1(i,j)=0;
        else 
           yb1(i,j)=(log(imgb(i,j))-log(nb1(i,j)));
        end   
        % 不知道什么地方出现了错误
    end
end
alf1=5000; %定义标准差alf=a^2/2  a=100
n=351;%
n1=floor((n+1)/2);%计算中心
for i=1:n
    for j=1:n
      b(i,j) =exp(-((i-n1)^2+(j-n1)^2)/(4*alf1))/(4*pi*alf1); %这个系数不知道有没有影响了
    end
end 
sum1=sum(sum(b));
b=b/sum1;% 
nr1 = double(imfilter(imgr,b,'conv', 'replicate'));% 滤波器？？
ng1 = double(imfilter(imgg,b,'conv', 'replicate'));
nb1 = double(imfilter(imgb,b,'conv', 'replicate'));%卷积滤波
fil=cat(3,nr1,ng1,nb1);% 这个地方进行模糊是没有问题的
[h0,w0]=size(imgr); 
for i=1:h0
    for j=1:w0      
        % 通过循环进行控制
        if(imgr(i,j)==0)||(nr1(i,j)==0)
           % 这个地方透射率必然是0
           yr2(i,j)=0;
        else 
           yr2(i,j)=(log(imgr(i,j))-log(nr1(i,j)));% 
        end        
        if(imgg(i,j)==0)||(ng1(i,j)==0)
           % 这个地方透射率必然是0
           yg2(i,j)=0;
        else 
           yg2(i,j)=(log(imgg(i,j))-log(ng1(i,j)));
        end        
        if(imgb(i,j)==0)||(nb1(i,j)==0)
           % 这个地方透射率必然是0
           yb2(i,j)=0;
        else 
           yb2(i,j)=(log(imgb(i,j))-log(nb1(i,j)));
        end   
    end
end
alf1=45000; %定义标准差alf=a^2/2  a=300
n=351;%模板的大小好像没什么大的影响
n1=floor((n+1)/2);%计算中心
for i=1:n
    for j=1:n
      b(i,j) =exp(-((i-n1)^2+(j-n1)^2)/(4*alf1))/(4*pi*alf1); %
    end
end % 
sum1=sum(sum(b));% 
b=b/sum1;% 归一化
nr1 = double(imfilter(imgr,b,'conv', 'replicate'));% 滤波器？？
ng1 = double(imfilter(imgg,b,'conv', 'replicate'));
nb1 = double(imfilter(imgb,b,'conv', 'replicate'));%卷积滤波
fil=cat(3,nr1,ng1,nb1);%
[h0,w0]=size(imgr); 
for i=1:h0
    for j=1:w0      
        % 通过循环进行控制
        if(imgr(i,j)==0)||(nr1(i,j)==0)
           % 这个地方透射率必然是0
           yr3(i,j)=0;
        else 
           yr3(i,j)=(log(imgr(i,j))-log(nr1(i,j)));% 这个地方计算的不准确啊。。。
           % 看来还是这个地方计算有问题
        end        
        if(imgg(i,j)==0)||(ng1(i,j)==0)
           % 这个地方透射率必然是0
           yg3(i,j)=0;
        else 
           yg3(i,j)=(log(imgg(i,j))-log(ng1(i,j)));
        end        
        if(imgb(i,j)==0)||(nb1(i,j)==0)
           % 这个地方透射率必然是0
           yb3(i,j)=0;
        else 
           yb3(i,j)=(log(imgb(i,j))-log(nb1(i,j)));
        end   
        % 不知道什么地方出现了错误
    end
end
imgout_r=(yr1+yr2+yr3)/3;% 如果不去拉伸，亮度会很低的
imgout_g=(yg1+yg2+yg3)/3;
imgout_b=(yb1+yb2+yb3)/3;

mean_r=mean2(imgout_r);% 对视网膜增强之后的图像进行拉伸处理
mean_g=mean2(imgout_g);
mean_b=mean2(imgout_b);
var_r=std2(imgout_r);
var_g=std2(imgout_g);
var_b=std2(imgout_b);
min_r=mean_r-2*var_r;  
max_r=mean_r+2*var_r;  
min_g=mean_g-2*var_g;  
max_g=mean_g+2*var_g; 
min_b=mean_b-2*var_b;  
max_b=mean_b+2*var_b;  
imgoutr=255*(imgout_r-min_r)/(max_r-min_r);
imgoutg=255*(imgout_g-min_g)/(max_g-min_g);
imgoutb=255*(imgout_b-min_b)/(max_b-min_b);
res_out=cat(3,imgoutr,imgoutg,imgoutb);% 实践证明，上面这个拉伸和直方图拉效果很像。。
figure
subplot(121),imshow(uint8(img)),title('原始输入图像');
subplot(122),imshow(uint8(res_out)),title('增强之后的图像');%
figure,
subplot(321),imhist(uint8(img(:,:,1))),title('原始图像直方图R');
subplot(322),imhist(uint8(res_out(:,:,1))),title('处理图像直方图R');
subplot(323),imhist(uint8(img(:,:,2))),title('原始图像直方图G');
subplot(324),imhist(uint8(res_out(:,:,2))),title('处理图像直方图G');
subplot(325),imhist(uint8(img(:,:,3))),title('原始图像直方图B');
subplot(326),imhist(uint8(res_out(:,:,3))),title('处理图像直方图B');