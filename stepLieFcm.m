function [U_new, center, obj_fcn] = stepLieFcm(data_g,U,cluster_n,expo,wAvg,x,y,seeds)





mf = U.^expo;       % mf中一列代表一个样本 一行代表一类(U同理)
% center = mf*data./(sum(mf,2)*ones(1,size(data,2))); %fcm中new center
%[类别数 样本数]*[样本数 特征维度]=[类别数 特征维度]

center=zeros(size(data_g,1),size(data_g,2),size(mf,1));


u_sum=sum(mf,2);
for i=1:size(mf,1)
    c=reshape(mf(i,:),1,1,[]);
    c=sum(c.*(data_g),3);
%     center(:,:,i)=expm(c./u_sum(i));
    center(:,:,i)=c./u_sum(i);
end %得到聚类中心


% dist = distfcm(center, data);       % fcm中的dist：一列代表一个样本 一行代表类

aSum = 0;

dist = zeros(size(center, 3), size(data_g, 3));
for i=1:size(center, 3)
    tmp=data_g-center(:,:,i);
    tmp=tmp.^2;
    tmp=sum(tmp,[1 2]);
    tmp=reshape(tmp,1,[]);
    tmp=tmp.^(1/2);
    dist(i,:)=tmp;
end

dist2 = zeros(size(center, 3), size(data_g, 3));
for i=1:size(center, 3)
    seedTemp=cell2mat(seeds(i));
    aSum=aSum+size(seedTemp,3);
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

a=aSum/size(mf,1);

loss=window_calc(U,expo,wAvg,x,y);



obj_fcn = sum(sum((mf.*(dist.^2+a*dist2.^2)+mf.*loss)));  % new objective function
tmp = ((dist.^2+a*dist2.^2)+loss).^(-1/(expo-1));      % 

% obj_fcn = sum(sum(mf.*(dist.^2+dist2.^2)));  % objective function
% tmp = (dist.^2+dist2.^2).^(-1/(expo-1));      % calculate new U, suppose expo != 1

% obj_fcn = sum(sum((mf.*(dist.^2)+mf.*loss)));  % objective function
% tmp = ((dist.^2)+loss).^(-1/(expo-1));      % calculate new U, suppose expo != 1

% obj_fcn = sum(sum(mf.*(dist.^2)));  % objective function
% tmp = (dist.^2).^(-1/(expo-1));      % calculate new U, suppose expo != 1

U_new = tmp./(ones(cluster_n, 1)*sum(tmp)); %得到隶属度矩阵

