function U_out(fn,names,opt)
if isempty(names)
    dlmwrite(fn,'');
    return
end

if ~exist('opt','var');opt=1;end
switch opt
case 0
    dlmwrite(fn,'');
    for i=1:numel(names)
        dlmwrite(fn,names{i},'delimiter','','-append')
    end
case 1
    fid = fopen(fn,'w');
    if numel(names{1})>1 &&strcmp(names{1}(end-1:end),'\n')
        for i=1:numel(names)
            fprintf(fid,names{i});
        end
    else
        for i=1:numel(names)
            fprintf(fid,[names{i} '\n']);
        end
    end
    fclose(fid);
end
