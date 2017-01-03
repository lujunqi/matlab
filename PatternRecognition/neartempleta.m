function y = neartempleta(data)
%data------待识别的手写数字特征向量
%y-----------识别结果
load templet.mat pattern;  %加载特征库中的样品
d = 0;
min = [inf,0];
for i = 1:10
    for j = 1:pattern(i).num
        d = sqrt(sum((pattern(i).feature(:,j)-data').^2));  %计算待识别手写数字到特征库某样品的距离
        if(min(1)>d)
            min(1) = d;
            min(2) = i-1;
        end
    end
end
y = min(2);  %返回识别结果
end

