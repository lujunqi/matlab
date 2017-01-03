% ������������ȡ
function opticdisk = opticDisk(I,maxRatio )
hsv = rgb2hsv(I);
V = hsv(:,:,3); % ����
mx = max(max(V));
me = mean(V(:)); %ȫ��ƽ��
%     disp (strcat('������ȣ�',num2str(mx)));% �������
%     disp(strcat('ƽ�����ȣ�',num2str(me))); % ƽ������

N = me + (mx-me)*0.75;
% ��������
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
%     disp(strcat('���ȣ�',num2str(step)));
%     disp(strcat('�����ٷֱȣ�',num2str(Ratio)));

% ��ʴ
se3=strel('disk',10);
J1=imerode(V2,se3);
opticdisk= J1;

% ���
%     subplot(2,2,1);
%     imhist(V);
%     subplot(2,2,2);
%     imshow(J);
%     subplot(2,2,3);
%     imshow(J1);
%     subplot(2,2,4);
%     imshow(opticdisk);
end

