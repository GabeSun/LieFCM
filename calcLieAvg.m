function avg = calcLieAvg(feature)
%CALCLIEAVG 此处显示有关此函数的摘要
%   此处显示详细说明
lieSum=zeros(size(feature,1),size(feature,2));
for i=1:size(feature,3)
    lieSum=lieSum+logm(feature(:,:,i));
end

avg=(lieSum/size(feature,3));
% avg=exmp(lieSum/size(feature,3));
end

