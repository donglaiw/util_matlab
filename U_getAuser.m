function y=U_getAmt(DD,ind,delim)
if ~exist('delim','var');delim='_';end

fn = dir([DD '*.save']);
y = cell(1,numel(fn));
for i=1:numel(fn)
    tmp = strspit(fn(i).name,delim);
    y{i} = tmp{ind};
end
