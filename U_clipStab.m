function ims=U_clipStab(Hs,ind,imN,minSide)
    if ~exist('minSide','var');minSide=64;end

    numF = numel(ind);
    numM = floor(numF/2);
    ims = cell(1,numel(ind));
    % project to the center frame
    ims{numM} = im2single(imread([imN(ind(numM))]));
    A=eye(3);
    % find non-black corner
    bd=repmat([1,1,size(ims{numM},1),size(ims{numM},2)],numF,1);
    for l = numM+1:numF
        for j=ind(l-1):ind(l)-1
            tmpH = Hs(:,:,j);
            if cond(tmpH)<100;
                A = A * tmpH;
            end
        end
        t = projective2d(A');
        im = im2single(imread([imN(ind(l))]));
        ims{l} = U_imwarp(im,t.invert);
        tmp_im = imfill(sum(isnan(ims{l}),3)==0,'holes');
        bd(l,:)=U_findRect3(tmp_im);
    end
    A=eye(3);
    for l = numM-1:-1:1
        for j=(ind(l+1)-1):-1:ind(l)
            tmpH = Hs(:,:,j);
            if cond(tmpH)<100;
                A =  tmpH * A;
            end
        end
        t = projective2d(A');
        im = im2single(imread([imN(ind(l))]));
        ims{l} = U_imwarp(im,t);
        tmp_im = imfill(sum(isnan(ims{l}),3)==0,'holes');
        bd(l,:)=U_findRect3(tmp_im);
    end
    % crop out the black region
    % naive count
    bb = [max(bd(:,1:2),[],1) min(bd(:,3:4),[],1)];
    %make sure the smaller side is 64 
    if minSide>0
        sz = [minSide,nan];
        if bb(3)-bb(1)>bb(4)-bb(2);sz=sz([2,1]);end
        % small motion 
        if min(bb(3)-bb(1),bb(4)-bb(2))>150
            for j=1:numel(ims)
                ims{j} = imresize(ims{j}(bb(1):bb(3),bb(2):bb(4),:),sz);
            end
        end
    end

