function y = neartempleta(data)
%data------��ʶ�����д������������
%y-----------ʶ����
load templet.mat pattern;  %�����������е���Ʒ
d = 0;
min = [inf,0];
for i = 1:10
    for j = 1:pattern(i).num
        d = sqrt(sum((pattern(i).feature(:,j)-data').^2));  %�����ʶ����д���ֵ�������ĳ��Ʒ�ľ���
        if(min(1)>d)
            min(1) = d;
            min(2) = i-1;
        end
    end
end
y = min(2);  %����ʶ����
end

