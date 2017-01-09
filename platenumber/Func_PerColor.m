%% 图片中颜色(蓝色)比例
function  per = Func_PerColor( I )
p=[0.56 0.71 0.4 1 0.3 1 0];
color = 0;
blue = 0;
[y,x,z]=size(I);
for i = 1 : y
    for j = 1 : x
        hij = I(i, j, 1);
        sij = I(i, j, 2);
        vij = I(i, j, 3);
        if (hij>=p(1) && hij<=p(2)) &&( sij >=p(3)&& sij<=p(4))&&...
                (vij>=p(5)&&vij<=p(6))  % 蓝色
            blue = blue+1;
        end
        color = color +1;
    end
end



per = blue / color;
end

