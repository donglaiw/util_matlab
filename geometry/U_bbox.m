function bb=U_bbox(im,opt,sz)
if ~exist('opt','var');opt=1;end
if nnz(im)==0
    bb=[];
else
    [a,b]=bwlabel(im);
    if (opt==1 || b==1)
        % find bbox for the biggest region
        [~,c]=max(histc(a(:),1:b));
    elseif opt== 2
        % size thres
        count=histc(a(:),1:b);
        c = find(count>=sz(1) & count<=sz(2));
        if isempty(c)
            [~,c]=max(count);
        else % select by densinty
            den=zeros(1,numel(c));
            for j=1:numel(c)
                ind = find(a==c(j));
                [xx,yy] = ind2sub(size(im),ind);
                den(j)= numel(ind)/(range(xx)*range(yy));
            end
            [~,cid]=max(den);c=c(cid);
        end
    end
    [xx,yy] = ind2sub(size(im),find(a==c));
    bb= [min(xx) max(xx) min(yy) max(yy)];
end
