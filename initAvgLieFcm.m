function U = initAvgLieFcm(expo,cluster_n, data_g, center, seeds)




dist = zeros(size(center, 3), size(data_g, 3));% (中心数，样本数)
dist2 = zeros(size(center, 3), size(data_g, 3));% (中心数，样本数)
for i=1:size(center, 3)
    tmp=data_g-center(:,:,i);
    tmp=tmp.^2;
    tmp=sum(tmp,[1 2]);
    tmp=reshape(tmp,1,[]);
    tmp=tmp.^(1/2);
    dist(i,:)=tmp;
end

for i=1:size(center, 3)
    seedTemp=cell2mat(seeds(i));
    distTemp = zeros(size(seedTemp, 3), size(data_g, 3));
    for j=1:size(seedTemp,3)
        tmp=data_g-seedTemp(:,:,j);
        tmp=tmp.^2;
        tmp=sum(tmp,[1 2]);
        tmp=reshape(tmp,1,[]);
        tmp=tmp.^(1/2);
        distTemp(j,:)=tmp;
    end
    dist2(i,:)=sum(distTemp)/size(seedTemp,3);
end

tmp = ((dist.^2+dist2.^2)).^(-1/(expo-1));     % calculate new U, suppose expo != 1
U = tmp./(ones(cluster_n, 1)*sum(tmp)); %得到隶属度矩阵

