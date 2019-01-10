% function Formation
% 画出编队运动轨迹图像
% 作者：李欣
% 单位：上海海事大学水下机器人实验室
% 2018-10-30
% Shanghai, China

clear all; 
close all; 

xmin = [0; 0];  
xmax = [50;50]; 

Step = 30;
%%%%%%%%%%%%%%%%%%%%%
%设置机器人的参数%
%%%%%%%%%%%%%%%%%%%%%
Dmin = 1;
count = 0;

Target=[19 20; 14 16.2; 9 12; 15 8.9; 21 6; 20 13]'-2;
Robot = [19 15 10 16 23 18;17 18 11 9 5 12]-2;
Target = [Target(1,:)-2;Target(2,:)];
Robot = [Robot(1,:)-2;Robot(2,:)];
Mat = size(Target); 
TarNum = Mat(1,2);

Target2 = Target;
xx = 1:10;
figure
for i = 1:20
    F = plot(Target2(1,:),Target2(2,:),'dk','MarkerSize',9);
    
    hold on
    G = plot([Target2(1,:),Target2(1,1)],[Target2(2,:),Target2(2,1)],'-.b','LineWidth',1);
    
    
    TargetLx(i) = Target2(1,1);
    TargetLy(i) = Target2(2,1);
    
    if(i <= 10) 
        deltaY = xx(i)^0.5;
    end
    if(i >10 )
        deltaY = xx(i-10)^-0.5;
    end
    Target2(1,:) = Target2(1,:) + 1.5; 
    Target2(2,:) = Target2(2,:) + deltaY;

    axis([0 50 0 50]);
end

h = plot(TargetLx,TargetLy,'m','linewidth',3);
legend([F,G,h],'Desired formation points','Formation shape', 'Formation trajectory');

hold off


Weight{1} = Robot;
B = 0.1; % 可调参数
r = 2; % 可调参数
w = 1;

for nn = 1:20
    for t = 1:Step
        %  for jj=1:length(xx)
        for ii=1:TarNum
            [Dist{t}(ii),ind(ii),distn] = distfunction_a(Target(:,ii),Robot);
            
            %  end
            Nk = ii;
            %    [Distk,Nk] = min(Dist);
            Nm = ind(Nk);
            
            winnerR = Weight{w}(:,Nm);
            winnerT = Target(:,Nk);
            
            Neigh = NeighborFunction(Weight{w},winnerR,r);
            Weight{w+1} = update(Weight{w},B,Neigh,distn,winnerT,Dist{t}(ii));
            w = w + 1;
        end
        
        count = count +1;
        if(count == 5)
            figure;
            plot(Target(1,:),Target(2,:),'dk','MarkerSize',12);
            hold on
            
            plot(Weight{w}(1,:),Weight{w}(2,:),'dr','MarkerSize',12,'MarkerFaceColor','r');
            plot([Target(1,:),Target(1,1)],[Target(2,:),Target(2,1)],'-.b','LineWidth',3);
            axis([0 50 0 50]);
            legend('期望编队','AUVs');
            hold off
            
            count = 0;
        end
        
    end
    Robot = Weight{w};
    if(nn <= 10)
        deltaY = xx(nn)^0.5;
    end
    if(nn >10 )
        deltaY = xx(nn-10)^-0.5;
    end
    Target(1,:) = Target(1,:) + 1.5;
    Target(2,:) = Target(2,:) + deltaY;
    
end

figure
F = plot(Weight{1}(1,:),Weight{1}(2,:),'dr','MarkerSize',9,'MarkerFaceColor','r');
hold on
G = plot([Weight{1}(1,:),Weight{1}(1,1)],[Weight{1}(2,:),Weight{1}(2,1)],'-.b','LineWidth',1);
Robotx(1) = Weight{1}(1,1);
Roboty(1) = Weight{1}(2,1);

for i = 1:30
    plot(Weight{i*120}(1,:),Weight{i*120}(2,:),'dr','MarkerSize',9,'MarkerFaceColor','r');
    axis([0 50 0 50]);
    Robotx(i+1) = Weight{i*120}(1,1);
    Roboty(i+1) = Weight{i*120}(2,1);
    legend('AUVs','Formation shape');
    plot([Weight{i*120}(1,:),Weight{i*120}(1,1)],[Weight{i*120}(2,:),Weight{i*120}(2,1)],'-.b','LineWidth',1);
    
end
h = plot(Robotx,Roboty,'m','linewidth',3);
legend([F,G,h],'Desired formation points','Formation shape', 'Formation trajectory');
hold off


