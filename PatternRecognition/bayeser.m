function y = bayeser( data )
%data----��ʶ����Ʒ����
%y-------ʶ����
clc;
load templet.mat pattern;
sum = 0;
pw = []; %�������
pwx = [];   %�������
%��ȡ�������
for i = 1:10
    sum = sum+pattern(i).num;
end
for i = 1:10
    pw(i) = pattern(i).num/sum;
end

%������������
for i = 1:10
    for j = 1:25
        sum = 0;
        for k = 1:pattern(i).num
            if(pattern(i).feature(j,k)>0.05)
                sum = sum+1;
            end
        end
        p(j,i) = (sum+1)/(pattern(i).num+2);
    end
end

for i = 1:10
    sum = 1;
    for j = 1:25
        if(data(j)>0.05)
            sum = sum*p(j,i);
        else
            sum = sum*(1-p(j,i));
        end
    end
    pxw(i) = sum;
end
%��������
sum = 0;
for i = 1:10
    sum = sum+pw(i)*pxw(i);
end
for i = 1:10
    pwx(i) = pw(i)*pxw(i)/sum;
end
[maxval,maxpos] = max(pwx);

y = maxpos-1;
end

