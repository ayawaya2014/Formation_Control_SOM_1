function dist = distfunction_Neigh(Weight,winner) 

% �����ƺ����������˶��켣ͼ��
% ���ߣ�����
% ��λ���Ϻ����´�ѧˮ�»�����ʵ����
% 2008-10-30
% Shanghai, China 


%obstacles
%x m=2 n=20
[m,n] = size(Weight);
dist = winner*ones(1,n) - Weight; % 2*1��1*n������ˣ��൱�ڵ�ֵ��չ��
% dist = (sum(dist.^2)).^2; % ����ƽ�����
dist = sqrt(sum(dist.^2)); % ����ƽ�����
% [J,ind] = min(dist); % ֻ����Ӱ������һ���ϰ���
% if J >= 0.2
%     J = w1*5.5*exp(-sigma*J); %��ָ����Ϊ�Ƴ�����
% else 
 %   J = w1*4.5*exp(-sigma*0.2);
% end