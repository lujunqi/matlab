% 视盘特征点提取
function opticdisk = opticDisk(I,maxRatio )
hsv = rgb2hsv(I);
V = hsv(:,:,3); % 亮度
mx = max(max(V));
me = mean(V(:)); %全部平均
%     disp (strcat('最大亮度：',num2str(mx)));% 最大亮度
%     disp(strcat('平均亮度：',num2str(me))); % 平均亮度

N = me + (mx-me)*0.75;
% 视盘亮化
%     J = imadjust(I,[step mx],[]);
threshold  = me;
V2 = V;
while(N>maxRatio && threshold<mx)
    
    V2 = V;
    J=find(V2>=threshold );
    K=find(V2<threshold );
    V2(J) = 1;
    V2(K) = 0;
    
    N = numel(J)/numel(I);

    threshold  = threshold+0.1;
end;
%     while(Ratio<maxRatio)
%         step = step + 0.01;
%         if(step >= mx)
%             break;
%         end;
%         J = imadjust(I,[step mx],[]);
%         Ratio = sum(~J(:))/numel(J);
%     end;
%     disp(strcat('亮度：',num2str(step)));
%     disp(strcat('背景百分比：',num2str(Ratio)));

% 腐蚀
se3=strel('disk',10);
J1=imerode(V2,se3);
opticdisk= J1;

% 输出
%     subplot(2,2,1);
%     imhist(V);
%     subplot(2,2,2);
%     imshow(J);
%     subplot(2,2,3);
%     imshow(J1);
%     subplot(2,2,4);
%     imshow(opticdisk);
end

