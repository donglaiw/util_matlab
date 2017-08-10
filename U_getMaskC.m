function mm=U_getMaskC(im,bid) 
% color threshold: white/orange/red
cmap=rgb2hsv(im);
mB=im(:,:,1); 
mm=mB>100; % remove blue bg
switch bid
case 1;mm=mm&(min(im(:,:,2:3),[],3)>120); %white
case 2;mm=mm&(im(:,:,3)<120)&(cmap(:,:,1)<0.75)&(cmap(:,:,2)>0.5); % orange: not white or red
case 3;mm=mm&(cmap(:,:,1)>0.75); %red
end
 
