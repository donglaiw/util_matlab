function images= U_prep(im,sz,crop,mm)
if ~exist('sz','var')||isempty(sz);sz=224;end
if ~exist('crop','var')||isempty(crop);crop=0;end

sz0=256;
im=single(im);
switch crop
case 0
    if size(im,1)~=sz(1) || size(im,2)~=sz(2)
        % resize
        im = imresize(im,[sz sz]);
    end
    im = im(:,:,3:-1:1,:);
    im = permute(im,[2,1,3,4]);
    if exist('mm','var')
        images=bsxfun(@minus,im,mm);
    else
        images=bsxfun(@minus,im,reshape([103.939, 116.779, 123.68],[1,1,3,1]));
    end
case 1
    if size(im,1)~=sz || size(im,2)~=sz
        % resize
        im = imresize(im,[sz sz]);
    end
    im= im(:,:,1:2,:);
    % remove third channel
    im = permute(im,[2,1,3,4]);
    images=im-128;
case 2
        if size(im, 1) < size(im, 2)
            im = imresize(im, [sz0 NaN]);
        else
            im = imresize(im, [NaN sz0]);
        end
        % RGB -> BGR
        im = im(:, :, [3 2 1]);
        % oversample (4 corners, center, and their x-axis flips)
        images = zeros(sz, sz, 3, 10, 'single');
        indices_y = [0 size(im,1)-sz] + 1;
        indices_x = [0 size(im,2)-sz] + 1;
        center_y = floor(indices_y(2) / 2)+1;
        center_x = floor(indices_x(2) / 2)+1;
        % hack the mean image
        IMAGE_MEAN =  repmat(reshape([103.939, 116.779, 123.68],[1,1,3]),[sz sz]);
        curr = 1;
        for i = indices_y
            for j = indices_x
                images(:, :, :, curr) = ...
                    permute(im(i:i+sz-1, j:j+sz-1, :)-IMAGE_MEAN, [2 1 3]);
                images(:, :, :, curr+5) = images(end:-1:1, :, :, curr);
                curr = curr + 1;
            end
        end
        images(:,:,:,5) = ...
            permute(im(center_y:center_y+sz-1,center_x:center_x+sz-1,:)-IMAGE_MEAN, ...
            [2 1 3]);
        images(:,:,:,10) = images(end:-1:1, :, :, curr);
end


