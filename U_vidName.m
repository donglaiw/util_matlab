function U_vidName(id,i,opt,pre)
if ~exist('pre','var');pre='';end
if ~exist('opt','var');opt=1;end

switch opt
case 1
    aa=textread(['../data/gcook/dw/' pre num2str(id) '.txt'],'%s','delimiter','\n');
    aa{i}
case 2
    for j=1:480
        aa=textread(['../data/gcook/dw/' pre num2str(j) '.txt'],'%s','delimiter','\n');
        ind = find(ismember(aa,['https://www.youtube.com/watch?v=' id]));
        if numel(ind)>0
            disp(sprintf('%d-%d',j,ind))
            break
        end
    end
end
