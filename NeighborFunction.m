function neigh = NeighborFunction(weight,winner,r)

G = 5; % 可调整参数
a = 0.1;
mat = size(weight);
n = mat(1,2);
dist = distfunction_Neigh(weight,winner);
neigh = 0 * ones(1,n);
for i = 1:n
    if(dist(i) >= r)
        neigh(i) = 0;
    end
    if(dist(i) < r)
        neigh(i) = exp(-dist(i)/((1-a) * G));
    end
end