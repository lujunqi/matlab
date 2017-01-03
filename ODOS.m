% ���� ��������ͼ �ж� ������
function odos = ODOS( img)
    w=size(img,2);
    l=size(img,1);
    left = imcrop(img,[0,0,w/2,l]);
    leftRatio = sum(~left(:))/numel(left);
    right = imcrop(img,[w/2,0,w/2,l]);
    rightRatio = sum(~right(:))/numel(right);
    if(rightRatio<leftRatio)
       odos = 'OD';
    else
       odos = 'OS';
    end;
end

