function centerSeq = centerSort(center,dim)
%CENTERSORT 此处显示有关此函数的摘要
%   dim:聚类中心的维度，1为一维向量，2为二维矩阵

a=[1:size(center,1)]';

if dim==1
    b=center(:,1);% 用灰度来排序
end

if dim==2
    a=[1:size(center,3)]';
    b=zeros(size(center,3),1);
    for i=1:size(center,3)
        b(i)=norm(center(:,:,i),"fro");
    end
end


center_sort=[b a];
centerSeq=sortrows(center_sort,1);
centerSeq=centerSeq(:,2);
end

