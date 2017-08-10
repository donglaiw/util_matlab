function feat= U_getFeat(net,ims,batchNum)
sz = size(ims);
numIm =  sz(4);
feat =zeros(4096,numIm);
numB = floor(numIm/batchNum);
for bid = 1:numB
    ind = (bid-1)*batchNum+(1:batchNum);
    tmp= net.forward({ims(:,:,:,ind)});
    feat(:,ind)=tmp{1};
end
numRest = numIm-numB*batchNum;
if numRest>0
    tmp= net.forward({cat(4,ims(:,:,:,end-numRest+1:end),zeros([sz(1:3) batchNum-numRest],'single'))});
    feat(:,end-numRest+1:end)=tmp{1}(:,1:numRest);
end

