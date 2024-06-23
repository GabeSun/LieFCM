function position = position_take(x,y,xmax)
%POSITION_TAKE 根据像素的行列,得到像素在特征向量集中的位置(x为行，y为列)
position=xmax*(y-1)+x;
end

