function weight_new = update(weight,B,Neigh,dist,winnerT,Dmin)

% Dmin = 1;
n = size(weight);
% n = size(winnerT)
i = n(1,2);
eta = 0.05;
% [angle_x,angle_y] = angle(winnerT,weight);
% weight_new = weight + [B*dist*angle_x;B*dist*angle_y]; 
for j = 1:i
    [angle_x,angle_y] = angle(winnerT,weight(:,j));
     if(dist(j) < eta*Dmin || isnan(dist(j)))
          weight_new(:,j) =weight(:,j);
    else
        weight_new(:,j) = weight(:,j) + [B*Neigh(j)*dist(j)*angle_x;B*Neigh(j)*dist(j)*angle_y]; % Neigh(j) 中只有一个是1.
    end
end


