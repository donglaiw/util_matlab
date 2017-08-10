function U_imshow(ims)
numR=ceil(sqrt(numel(ims)));
cc=1;
for i=1:numR
    for j=1:numR
        subplot(numR,numR,cc),imagesc(ims{cc})
        cc=cc+1;
        if cc>numel(ims);return;end
    end
end
