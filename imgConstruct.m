function imgConstruct(U,img_test,side1,side2,s)
% side1,side2为生成的实验结果预览图的子图行列
% x,y 图片尺寸，x为行数（即图片中y的范围而非x的范围）
% U 混淆矩阵 U(i,j)  第j个数据点属于第i个类的隶属度
[x,y]=size(img_test);
[r,c]=size(U);
% r为行数即类别数 c为列数即样本数

img_set=zeros(x*y,r); %图片类别集合


[U_max,category]=max(U);
%每一列是一个样本 max()取出每一列最大值 即隶属度最高的一类

for n=1:c       %c为样本数即像素数量
    img_set(n,s(category(n)))=1;
end

img_set=reshape(img_set,x,y,r);

subplot(side1,side2,1);imshow(img_test,[]);title('分割图像原图：')

for i=1:r
    subplot(side1,side2,i+1);imshow(img_set(:,:,i),[]);title(i)
end

subplot(side1,side2,side1*side2);imshow(reshape(category,x,y),[]);
% subplot(side1,side2,side1*side2);imshow(img_set(:,:,1)+img_set(:,:,2)*2+img_set(:,:,3)*3+img_set(:,:,4)*4,[])
% subplot(side1,side2,side1*side2);imshow(img_set(:,:,1)+img_set(:,:,2)*2+img_set(:,:,3)*3,[])
% subplot(side1,side2,side1*side2);imshow(img_set(:,:,1)+img_set(:,:,2)*2,[])


