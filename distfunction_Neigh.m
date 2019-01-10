function dist = distfunction_Neigh(Weight,winner) 

% 计算势函数，画出运动轨迹图像
% 作者：李欣
% 单位：上海海事大学水下机器人实验室
% 2008-10-30
% Shanghai, China 


%obstacles
%x m=2 n=20
[m,n] = size(Weight);
dist = winner*ones(1,n) - Weight; % 2*1与1*n矩阵相乘，相当于等值扩展了
% dist = (sum(dist.^2)).^2; % 把列平方相加
dist = sqrt(sum(dist.^2)); % 把列平方相加
% [J,ind] = min(dist); % 只考虑影响最大的一个障碍物
% if J >= 0.2
%     J = w1*5.5*exp(-sigma*J); %用指数作为势场函数
% else 
 %   J = w1*4.5*exp(-sigma*0.2);
% end