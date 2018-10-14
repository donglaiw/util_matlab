function U_h5write(fn,dataN,data, df, dt)
if ~exist('df','var');df=5;end % df=9: max compression, too slow to write..
if ~exist('dt','var');dt='uint8';end 

if ~exist(fn,'file') 
    sz = ceil(size(data)/20);
    h5create(fn,dataN,size(data),'Datatype',dt,'ChunkSize',sz,'Deflate',df);
end
h5write(fn,dataN,data);
