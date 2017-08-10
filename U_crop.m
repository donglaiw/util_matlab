function rgb=U_crop(rgb,k,sz0)
if ~exist('sz0','var');sz0=224;end
        sz = size(rgb);
        ww=floor((sz(1:2)-sz0)/2);
        if k>5;rgb=fliplr(rgb);end
            switch mod(k,5)
                case 1;rgb = rgb(1:sz0,1:sz0,:,:);
                case 2;rgb = rgb(1:sz0,end-sz0+1:end,:,:);
                case 3;rgb = rgb(ww(1):ww(1)+sz0-1,ww(2):ww(2)+sz0-1,:,:);
                case 4;rgb = rgb(end-sz0+1:end,1:sz0,:,:);
                case 0;rgb = rgb(end-sz0+1:end,end-sz0+1:end,:,:);
            end

