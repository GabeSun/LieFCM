
function result = cov_take_SOG(feature,filtImg)


[N,d]=size(feature); %N为邻域内像素个数，d为特征维度
result_temp=diag(feature(1,:));

zero_vector=zeros(1,d);

result=[result_temp filtImg';zero_vector 1];


end

