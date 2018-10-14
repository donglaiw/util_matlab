% function to warp images with different dimensions
function [warpI2,mask]=U_warpImage_f(im,vx,vy,mask)
% forward warping
[height2,width2,nchannels]=size(im);
[yy,xx]=meshgrid(1:width2,1:height2);
XX=xx+vx;
YY=yy+vy;
warpI2 = im2double(im);
XX = XX(:);
YY = YY(:);
if exist('mask','var')
    XX=XX(mask);
    YY=YY(mask);
end
%{
imshow(im);hold on,plot(XX,YY,'ro')
%}
for i=1:nchannels
    tmp = reshape(warpI2(:,:,i),[],1);
    if exist('mask','var')
        tmp=tmp(mask);
    end
    F = TriScatteredInterp(XX,YY, tmp);
    foo=F(xx,yy);
    warpI2(:,:,i)=foo;
end
warpI2(warpI2>1)=1;
warpI2(warpI2<0)=0;

k = convhull((YY),(XX));
mask=inpolygon(yy,xx,YY(k),XX(k));

%{
ind = yy*height2+xx;
ind2 = unique(round(YY)*height2+round(XX);
bid = ~ismember(ind(:),ind2(:));
mask=uint8(ones([height2,width2]));
mask(bid)=0;
%mask=1-mask;
%}
