function [J,ind,distn] = distfunction_a(x,Robot) 

%obstacles
%x m=2 n=20
[m,n] = size(Robot);
dist = x*ones(1,n) - Robot; 
dist = sum(dist.^2); 
distn = dist.^0.5;
[J,ind] = min(distn);
% distn = dist.^0.5;
% if J >= 0.2
%     J = w1*5.5*exp(-sigma*J); %用指数作为势场函数
% else 
 %   J = w1*4.5*exp(-sigma*0.2);
% end