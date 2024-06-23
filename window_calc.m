function out=window_calc(U, expo, wAvg, image_r,image_c)

% 输出公式13中的新损失项 

n=size(U,2); % 样本数
c=size(U,1); % 类别数


wAvg=wAvg(:)';
a=mean(wAvg);
U_temp=reshape((1.-U').^expo,image_r,image_c,c);
window=[1 1 1;1 1 1;1 1 1];

for i=1:c
    U_temp(:,:,i)=conv2(U_temp(:,:,i),window,"same");
end

out=reshape(U_temp,n,c)';

out=a*(w_noweight/9).*out;
% out=(0.024/8).*out;
%输出中不带有 {u_ik}^{m} 便于复用函数