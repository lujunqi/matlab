% �۵�Ѫ��ͼ ����

f=imread('e:\yezi\0077.jpg');
f=rgb2gray(f);
figure,imshow(f,[]);
title('����Ĥ�۵�ͼ��Ҷ�ͼ��');
f=double(f);


%��������
os=12;%��ⷽ�����
tim=3;%���ڽضϸ�˹����
L=9;%�Ƚ�Ѫ�������һС��һС�ε�ƽ���������ϣ��趨����ΪL
T=40;%��ֵѡ��


step = [1 1.5 2 3 3.5 4];
%�߶�ѭ����ѡȡ�߶�
for is = 1:6
    sigma = step(is);
    
    thetas=0:(os-1);%ȡ0��11
    thetas=thetas.*(180/os);%.*��ʾ����ͬά�ȵľ����ӦԪ�����
    %��ʾÿ���������ʼλ����ת�ĽǶ�
    N1=-tim*sigma:tim*sigma;%�á�3sigma�ضϸ�˹����
    N1=-exp(-(N1.^2)/2*sigma*sigma);%N1��ÿ��Ԫ�ص�2����
    N=repmat(N1,[2*floor(L/2)+1,1]);%��N1��ɵģ�2*floor��L/2��+1��X1�ľ���
    RNs=cell(1,os);
    MFRs=cell(1,os);
    
    
    %ƥ���˲���������ѭ��
    for i=1:os %��1��os��Ԫ��
        theta=thetas(i);
        RN=imrotate(N,theta);%��ͼ��N�����ĵ���תtheta�Ƕ�
        %ȥ�������0��0��
        RN=RN(:,any(RN));%any���������ж��Ƿ����
        RN=RN(any(RN'),:);%'��ʾת��
        meanN=mean2(RN);%mean2(RN)�൱�� mean(mean(RN)),mean(a)Ĭ������о�ֵ
        RN=RN-meanN;
        RNs{1,i}=RN;
        MFRs{1,i}=imfilter(f,RN,'conv','symmetric');
    end
    
    
    %��ȡ�����Ӧ
    g=MFRs{1,1};
    for j=2:os
        g=max(g,MFRs{1,j});
    end
    
    
    figure,imshow(g,[]);
    title('ƥ���˲����ͼ��');
    
    
end