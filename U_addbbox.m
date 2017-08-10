function im0 = U_addbbox(im0,bbs,opt_fill,cc,width,bopt)
% x,y,w,h
if ~exist('opt_fill','var')  || isempty(opt_fill)
    opt_fill = false;
end
if ~exist('width','var')|| isempty(width)
    width=5;
end
if ~exist('cc','var') || isempty(cc)
    cc = uint8([255 255 0]);
else
    cc = uint8(cc);
end
if exist('bopt','var')
    % xmin,xmax ->height/width
    switch bopt
    case {1,2}
        bbs=[bbs(:,[1,3]) bbs(:,[2,4])-bbs(:,[1,3])+1];
    case {3,4}
        bbs=[bbs(:,[1,2]) bbs(:,[3,4])-bbs(:,[1,2])+1];
    end
    if mod(bopt,2)==0
        bbs=bbs(:,[2 1 4 3]);
    end
end
if size(im0,3)<numel(cc)
    im0 = repmat(im0,[1,1,numel(cc)]);
end
if size(bbs,2)==4
    bbs= [bbs zeros(size(bbs,1),1)];
end

% last dimension for rotation
ind = find(bbs(:,5)==0);
%ind = 1:size(bbs,1);
if opt_fill
    im0 = step(vision.ShapeInserter('Shape','Rectangles','Fill',opt_fill,'LineWidth',width,'FillColor','Custom','CustomFillColor', cc), im0, int32(bbs(ind,1:4)));
else
    im0 = step(vision.ShapeInserter('Shape','Rectangles','LineWidth',width,'BorderColor','Custom','CustomBorderColor', cc), im0, int32(bbs(ind,1:4)));
end

% polygon
ind = find(bbs(:,5)~=0);
pts = U_getRectPt(bbs(ind,1:5));
if opt_fill
    im0 = step(vision.ShapeInserter('Shape','Polygons','Fill',opt_fill,'LineWidth',width,'FillColor','Custom','CustomFillColor', cc), im0, int32(pts));
else
    im0 = step(vision.ShapeInserter('Shape','Polygons','LineWidth',width,'BorderColor','Custom','CustomBorderColor', cc), im0, int32(pts));
    % imagesc(step(vision.ShapeInserter('Shape','Polygons','LineWidth',width,'BorderColor','Custom','CustomBorderColor', cc), zeros(size(im0)), int32(pts)));
end
