function U = SemiLieFcm(imageFeature,x,y,C,m,maxIter,sb,labels)
%SEMILIEFCM 此处显示有关此函数的摘要
%Input:
%   imageFeature: [m,n], m is the number of pixels, n is the dim of the
%   feature;
%   x,y: image size
%   C: number of clusters;
%   m: fuzzy factor;
%   maxIter: maximum iteration;
%   sb: termination error of the clustering iteration;
%   labels:cell, No. of the labeled pixels;
%Output:   
%   U:Fuzzy membership matrix 
   
[featureMatrix,wAvg]=extractFeature(imageFeature,x,y); 
seeds={};
for i=1:C
    seedTemp = featureMatrix(:,:,cell2mat(labels(i)));
    initCenter(:,:,i)=calcLieAvg(seedTemp);
    seeds{i}=seedTemp;
end


data_n=size(imageFeature,1); 
data_g=zeros(size(featureMatrix,1),size(featureMatrix,1),data_n);
for i=1:data_n
    data_g(:,:,i)=logm(featureMatrix(:,:,i));
end

U=initAvgLieFcm(m,C,data_g,initCenter,seeds);

% 主程序
for i=1:maxIter  
    [U,center,obj_fun(i)]=stepLieFcm(data_g,U,C,m,wAvg,x,y,seeds);
    
    %显示聚类最终的函数值
    if display
        fprintf('FCM:Iteration count=%d,obj_fun=%f\n',i,obj_fun(i));
    end
    
    % 终止条件判断
    if i>1

        if abs(obj_fun(i)-obj_fun(i-1))<sb
%         if -(obj_fun(i)-obj_fun(i-1))<sb
            break;
        end
    end    
end


obj_fun(i+1:maxIter)=[];



end

