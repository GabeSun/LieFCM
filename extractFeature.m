function [featureMatrix,wAvg] = extractFeature(imageFeature,x,y)
%EXTRAC TFEATURE 

%x,y: image size

[m,n]=size(imageFeature);
filtImg=zeros(m,n);
w=zeros(m,n);
%生成各维度特征的滤波值
winSize=3;

for i=1:n
featureTemp=reshape(imageFeature(:,:,dim),[x,y]);
wTemp=PixWgt(gray_w,winSize);
a=[1,1,1;1,1,1;1,1,1];
filtImgTemp=1./(1+wTemp) .*((wTemp)/(winSize^2).* filter2(a,featureTemp)+featureTemp);
filtImg(:,i)=reshape(filtImgTemp,[],1);
w(:,i)=reshape(wTemp,[],1);
end


wAvg=reshape(sum(w,2)/n,[x,y]);

%生成李群矩阵特征
featureMatrix=zeros(n+1,n+1,x*y); %特征维度*特征维度*样本数量
for i=1:y %i是像素的列 
    for j=1:x %j是像素的行

        if i==1
            if j==1
                feature=[filtImg(position_take(j,i,x),:);
                             filtImg(position_take(j+1,i,x),:);
                             filtImg(position_take(j,i+1,x),:);
                             filtImg(position_take(j+1,i+1,x),:)];
                featureMatrix(:,:,position_take(j,i,x))=cov_take_SOG(feature,filtImg(position_take(j,i,x),:));

            elseif j==x
                feature=[filtImg(position_take(j,i,x),:);
                             filtImg(position_take(j-1,i,x),:);
                             filtImg(position_take(j,i+1,x),:);
                             filtImg(position_take(j-1,i+1,x),:)];
                featureMatrix(:,:,position_take(j,i,x))=cov_take_SOG(feature,filtImg(position_take(j,i,x),:));
            else
                feature=[filtImg(position_take(j,i,x),:);
                             filtImg(position_take(j-1,i,x),:);
                             filtImg(position_take(j+1,i,x),:);
                             filtImg(position_take(j,i+1,x),:);
                             filtImg(position_take(j-1,i+1,x),:);
                             filtImg(position_take(j+1,i+1,x),:)];
                featureMatrix(:,:,position_take(j,i,x))=cov_take_SOG(feature,filtImg(position_take(j,i,x),:));
            end
            
        elseif i==y
            if j==1
                feature=[filtImg(position_take(j,i,x),:);
                             filtImg(position_take(j+1,i,x),:);
                             filtImg(position_take(j,i-1,x),:);
                             filtImg(position_take(j+1,i-1,x),:)];
                featureMatrix(:,:,position_take(j,i,x))=cov_take_SOG(feature,filtImg(position_take(j,i,x),:));
            elseif j==x
                feature=[filtImg(position_take(j,i,x),:);
                             filtImg(position_take(j-1,i,x),:);
                             filtImg(position_take(j,i-1,x),:);
                             filtImg(position_take(j-1,i-1,x),:)];
                featureMatrix(:,:,position_take(j,i,x))=cov_take_SOG(feature,filtImg(position_take(j,i,x),:));
            else
                feature=[filtImg(position_take(j,i,x),:);
                             filtImg(position_take(j-1,i,x),:);
                             filtImg(position_take(j+1,i,x),:);
                             filtImg(position_take(j,i-1,x),:);
                             filtImg(position_take(j-1,i-1,x),:);
                             filtImg(position_take(j+1,i-1,x),:)];
                featureMatrix(:,:,position_take(j,i,x))=cov_take_SOG(feature,filtImg(position_take(j,i,x),:));
            end

        else
            if j==1
                feature=[filtImg(position_take(j,i,x),:);
                             filtImg(position_take(j+1,i,x),:);
                             filtImg(position_take(j,i-1,x),:);
                             filtImg(position_take(j+1,i-1,x),:);
                             filtImg(position_take(j,i+1,x),:);
                             filtImg(position_take(j+1,i+1,x),:)];
                featureMatrix(:,:,position_take(j,i,x))=cov_take_SOG(feature,filtImg(position_take(j,i,x),:));
            elseif j==x
                feature=[filtImg(position_take(j,i,x),:);
                             filtImg(position_take(j-1,i,x),:);
                             filtImg(position_take(j,i-1,x),:);
                             filtImg(position_take(j-1,i-1,x),:);
                             filtImg(position_take(j,i+1,x),:);
                             filtImg(position_take(j-1,i+1,x),:)];
                featureMatrix(:,:,position_take(j,i,x))=cov_take_SOG(feature,filtImg(position_take(j,i,x),:));
            else
                feature=[filtImg(position_take(j,i,x),:);
                             filtImg(position_take(j-1,i,x),:);
                             filtImg(position_take(j+1,i,x),:);
                             filtImg(position_take(j,i-1,x),:);
                             filtImg(position_take(j-1,i-1,x),:);
                             filtImg(position_take(j+1,i-1,x),:);
                             filtImg(position_take(j,i+1,x),:);
                             filtImg(position_take(j-1,i+1,x),:);
                             filtImg(position_take(j+1,i+1,x),:)];
                featureMatrix(:,:,position_take(j,i,x))=cov_take_SOG(feature,filtImg(position_take(j,i,x),:));
            end
        end

    end
end


end

