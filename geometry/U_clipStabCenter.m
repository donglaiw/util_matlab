function [out,bb]=U_clipStabCenter(ind0,inds,Hs,imN,minSide,thres)
    if ~exist('minSide','var');minSide=64;end
    if ~exist('thres','var');thres=150;end

    ss = [-1,1];
    ims = cell(1,2);
    bds = cell(1,2);
    % project to the center frame
    if isa(imN,'function_handle')
        im0 = im2single(imread([imN(ind0)]));
    else
        im0 = imN{ind0};
    end
    fprintf('\t1. start warping \n');
    for i=1:numel(inds)
        A=eye(3);
        % find non-black corner
        bds{i}=repmat([1,1,size(im0,1),size(im0,2)],numel(inds{i})-1,1);
        ims{i} = cell(1,numel(inds{i})-1);
        % forward Hs: avoid numerical inversion ...
        % pairwise matching: accumulated error ?
        % index from center to the end 
        for l = 1:numel(inds{i})-1
            for j=inds{i}(l):ss(i):(inds{i}(l+1)-ss(i))
                tmpH = Hs{i}(:,:,j);
                if cond(tmpH)<100;
                    %A =  A * tmpH;
                    A =  tmpH * A;
                end
            end
            t = projective2d(A');
            if isa(imN,'function_handle')
                im = im2single(imread([imN(inds{i}(l))]));
            else
                im = imN{inds{i}(l)};
            end
            ims{i}{l} = U_imwarp(im,t);
            tmp_im = imfill(sum(isnan(ims{i}{l}),3)==0,'holes');
            bds{i}(l,:)=U_findRect3(tmp_im);
        end
    end
    % U_ims2gif(cat(4,ims{i}{:},im0),'db.gif')
    % crop out the black region
    bb = [max(cat(1,bds{1}(:,1:2),bds{2}(:,1:2)),[],1) min(cat(1,bds{1}(:,3:4),bds{2}(:,3:4)),[],1)];
    %make sure the smaller side is 64 
    out = [];
    fprintf('\t2. start cropping \n');
    if minSide>0
        sz = [minSide,nan];
        if bb(3)-bb(1)>bb(4)-bb(2);sz=sz([2,1]);end
        if min(bb(3)-bb(1),bb(4)-bb(2))>thres
            % small motion 
            for i=1:numel(ims)
                for j=1:numel(ims{i})
                    ims{i}{j} = imresize(ims{i}{j}(bb(1):bb(3),bb(2):bb(4),:),sz);
                end
            end
            out = ims{1}(end:-1:1);
            out = cat(4,out{:},imresize(im0(bb(1):bb(3),bb(2):bb(4),:),sz),ims{2}{:});
        end
        % U_ims2gif(out,'db_all.gif')
    end

