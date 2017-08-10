function out=U_getF(D0,pref)

out=cell(10);
for i=0:9
    for ii=0:9
        tmp=dir([D0 sprintf('/%d/%d/',i,ii) pref '*']);
        out{i+1,ii+1} = {tmp.name};
    end
end
out=reshape(out,1,[]);
out=cat(2,out{:});
