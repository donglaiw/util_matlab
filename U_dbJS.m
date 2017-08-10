function sid=U_dbJS(fn,vv,sc,order)
if ~exist('sc','var');sc=[];end
if ~exist('order','var');order='ascend';end
fid=fopen(fn,'w');
sid=[];
if numel(sc)>0
    [sc2,sid]=sort(sc,order);
    vv=vv(sid);
    tmp=sprintf('%.2f,',sc2);
    fprintf(fid,['sc=[' tmp(1:end-1) '];\n'],'delimiter','');
end
tmp=sprintf('"%s",',vv{:});
fprintf(fid,['vv=[' tmp(1:end-1) '];\n'],'delimiter','');

fclose(fid);
