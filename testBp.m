x=[54167    
55196    
56300    
57482    
58796    
60266    
61465    
62828    
64653    
65994    
67207    
66207    
65859    
67295    
69172    
70499    
72538    
74542    
76368    
78534    
80671    
82992    
85229    
87177    
89211    
 90859    
 92420    
 93717    
 94974    
 96259    
 97542    
 98705    
100072    
101654    
103008    
104357    
105851    
107507    
109300    
111026    
112704    
114333    
115823    
117171    
118517    
119850    
121121    
122389    
123626    
124761    
125786    
126743    
127627    
128453    
129227    
129988    
130756    
131448    
132129    
132802    
134480    
135030    
135770    
136460    
137510]';
% �ýű�������NAR������Ԥ��
% ���ߣ�Macer��
lag=3;    % �Իع����
iinput=x; % xΪԭʼ���У���������
n=length(iinput);

%׼��������������
inputs=zeros(lag,n-lag);

for i=1:n-lag
    inputs(:,i)=iinput(i:i+lag-1)';
end
targets=x(lag+1:end);

%��������
hiddenLayerSize = 10; %���ز���Ԫ����
net = fitnet(hiddenLayerSize);

% �������ϣ�����ѵ�������Ժ���֤���ݵı���
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

%ѵ������
[net,tr] = train(net,inputs,targets);
%% ����ͼ���ж���Ϻû�
yn=net(inputs);
errors=targets-yn;
figure, ploterrcorr(errors)                      %������������������20lags��
figure, parcorr(errors)                          %����ƫ������
%[h,pValue,stat,cValue]= lbqtest(errors)         %Ljung��Box Q���飨20lags��
figure,plotresponse(con2seq(targets),con2seq(yn)) %��Ԥ���������ԭ����
%figure, ploterrhist(errors)                      %���ֱ��ͼ
%figure, plotperform(tr)                          %����½���


%% ����Ԥ������Ԥ�⼸��ʱ���
fn=7;  %Ԥ�ⲽ��Ϊfn��

f_in=iinput(n-lag+1:end)';
f_out=zeros(1,fn);  %Ԥ�����
% �ಽԤ��ʱ���������ѭ�������������������
for i=1:fn
    f_out(i)=net(f_in);
    f_in=[f_in(2:end);f_out(i)];
end
% ����Ԥ��ͼ
figure,plot(1949:2013,iinput,'b',2013:2020,[iinput(end),f_out],'r')