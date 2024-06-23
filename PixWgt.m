function w =PixWgt(img,winSize)

img=double(img);
h=fspecial('average',winSize);
avg=imfilter(img,h,'replicate');        
nhood=ones(winSize);
Vimg=stdfilt(img,nhood).^2;            
LVC=Vimg./(avg.^2);                   
LVC(isnan(LVC))=0;
sumLVC=imfilter(LVC,h,'conv');        
eta=exp(-(LVC-sumLVC));               
tempeta=imfilter(eta,nhood,'conv');     
w=eta./tempeta;   

ind1= find((avg)>img);
ind2= find(uint8(avg)<img);
w(ind1)=1-w(ind1);        
w(ind2)=1+w(ind2);          
w(uint8(avg)==img)=1;       

end