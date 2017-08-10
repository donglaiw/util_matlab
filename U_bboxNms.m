function out=U_bboxNms(bbox,ratio,opt)
if ~exist('opt','var');opt=1;end
% Nx4
nB = size(bbox,1);
ll=[1];
aa=prod(bbox(:,3:4),2);
for i=2:nB
    rr=zeros(1,numel(ll));
    bb=0;
    % too slow
    switch opt
    case 1
        for j=1:numel(ll)
            rr(j)=rectint(bbox(i,:),bbox(ll(j),:))/max(aa(i),aa(ll(j)));
            if rr(j)>=ratio;bb=1;break;end
        end
    case 2
        if nnz(max(abs(bsxfun(@minus,bbox(ll,:),bbox(i,:))),[],2)<ratio);
            bb=1;
        end
    end
    if ~bb
        ll=[ll,i];
    end
end
out=bbox(ll,:);
