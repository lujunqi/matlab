clear
clc
% ��������15*11
people_count=15;
face_count_per_people=11;
% ѵ������,70%ʱʶ����ȷ��Ϊ96.67%,����Ϊ75%ʶ����ȷ�ʿɴ�100%
training_ratio=.75;
% ����
energy=90;
training_count=floor(face_count_per_people*training_ratio);
training_samples=[];
path_mask='%03d\\%02d.jpg';

% ѵ��
for i=1:people_count
    for j=1:training_count
        img=im2double(imread(sprintf(path_mask,i,j)));
        img=imresize(img,[10 10]); % ��һ����50*50
        if ndims(img)==3
            img=rgb2gray(img);
        end
        training_samples=[training_samples;img(:)'];
    end
end
mu=mean(training_samples);
[coeff,scores,~,~,explained]=pca(training_samples);
idx=find(cumsum(explained)>energy,1);
coeff=coeff(:,1:idx);
scores=scores(:,1:idx);

% ����
acc_count=0;
for i=1:people_count
    for j=training_count+1:face_count_per_people
        img=im2double(imread(sprintf(path_mask,i,j)));
        img=imresize(img,[10 10]);
        if ndims(img)==3
            img=rgb2gray(img);
        end
        score=(img(:)'-mu)/coeff';
        [~,idx]=min(sum((scores-repmat(score,size(scores,1),1)).^2,2));
        if ceil(idx/training_count)==i
            acc_count=acc_count+1;
        end
    end
end
test_count=(people_count*(face_count_per_people-training_count));
acc_ratio=acc_count/test_count;
fprintf('������������:%d,��ȷʶ����:%2.2f%%',test_count,acc_ratio*100)