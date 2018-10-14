function pts = U_getRectPt(bbs,ref_pt,ref_pt2)
if ~exist('ref_pt','var')
    ref_pt = [];
else
    ref_pt = reshape(ref_pt,[2,1]);
end

if ~exist('ref_pt2','var')
    ref_pt2 = ref_pt;
else
    ref_pt2 = reshape(ref_pt2,[2,1]);
end
% Nx5 matrix: x,y,width,height,rot

pts = zeros(size(bbs,1),8);


% assume no rotation
pts(:,:) = repmat(bbs(:,1:2),[1,4]); % upper-left
pts(:,3) = pts(:,3)+bbs(:,3);  % upper-right
pts(:,5:6) = pts(:,5:6)+bbs(:,3:4);  % lower-right
pts(:,8) = pts(:,8)+bbs(:,4); % lower-left

% add rotation
ind = find(bbs(:,5)~=0);

if ~isempty(ind)
    pts2 = reshape(pts(ind,:)',2,4,[]);
    pts3 = pts2;
    for i=1:numel(ind)
        ang = bbs(ind(i),5)/180*pi;
        A = [cos(ang),-sin(ang);sin(ang),cos(ang)];
        if ~isempty(ref_pt)
            pts3(:,:,i) = A*bsxfun(@minus,pts2(:,:,i),ref_pt);
            pts3(:,:,i) = bsxfun(@plus,pts3(:,:,i),ref_pt2);
        else
            pts3(:,:,i) = A*bsxfun(@minus,pts2(:,:,i),pts2(:,1,i));
            pts3(:,:,i) = bsxfun(@plus,pts3(:,:,i),pts2(:,1,i));
        end
        
    end
    pts = reshape(pts3,8,[])';
end

function testcase()
%%
DD_o=  'result/oyster_0702/gt_dsp/';
nns={'train','test'};
DD = 'data/oyster_0702/';
for nid=1
    dd= load([DD 'oyster_' nns{nid}],'ims','xmls');
    for i=43
        im0 = imread(dd.ims{i});
        %bbs=U_xml2bbox(dd.xmls{i},'all');
        bbs=load('data/debug/test.png_bbox');
        bbs(:,5) = -bbs(:,5);
        %%
        im0 = imread(dd.ims{i});
        im0 = U_addbbox(im0,bbs);
        imagesc(im0)
    end
end
