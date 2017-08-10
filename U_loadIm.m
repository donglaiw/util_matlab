function y=U_loadIm(D0,fns,sz)
if ~exist('sz','var')
    sz=224;
end
y=zeros([sz sz 3 numel(fns)],'single');
if iscell(fns)
    for i=1:numel(fns)
        y(:,:,:,i) = imresize(imread([D0 fns{i}]),[sz sz]);
    end
else
    for i=1:numel(fns)
        y(:,:,:,i) = imresize(imread([D0 fns(i).name]),[sz sz]);
    end
end

