%load image

%main
U =  SemiLieFcm(imageFeature,x,y,C,m,iter,sb,labels);

%construct image
s=centerSort(center,runMode);
imgConstruct(U,brainDataImage,2,3,s)