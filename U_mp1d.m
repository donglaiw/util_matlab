function y=U_mp1d(arr,psz,psd)
% 1d max pooling
if psz==1
    y=arr;return;
end
ind = 1:psd:(numel(arr)-psz+1);
ind2 =  bsxfun(@plus,ind,(0:psz-1)');
y = max(arr(ind2));

