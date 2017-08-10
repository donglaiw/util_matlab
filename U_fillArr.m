function arr=U_fillArr(arr,val,opt)
if ~exist('opt','var');opt=0;end
% fill array for each column
for i=1:size(arr,2)
    tt=find(arr(:,i)==val);
    if numel(tt)>0
        dif = tt(2:end)-tt(1:end-1);
        chunk = find(dif~=1)';
        st = [1 chunk+1];
        lt = [chunk numel(tt)];
        for j=1:numel(st)
            ind = tt(st(j)):tt(lt(j));
            if j==1 && tt(1)==1
                % no front 
                if ind(end)<size(arr,1)
                    arr(ind,i) = arr(ind(end)+1,i); 
                end
            elseif j==numel(st) && tt(end)==size(arr,1)
                % no back
                arr(ind,i) = arr(ind(1)-1,i); 
            else
                switch opt
                case 0 % linear interp
                    tmp = linspace(arr(ind(1)-1,i),arr(ind(end)+1,i),numel(ind)+2); 
                    arr(ind,i) = tmp(2:end-1); 
                case 1 % left copy
                    arr(ind,i) = arr(ind(1)-1,i); 
                end
            end
        end
    end
end
