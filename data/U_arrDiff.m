function y=U_arrDiff(arr1,arr2)
if isempty(arr2)
    y=arr1;
else
    % arr1 - arr2
    u1 = unique(arr1);
    s1 = histc(arr1,u1);
    s2 = histc(arr2,u1);
    s1 = max(s1-s2,0);

    y=arrayfun(@(x) u1(x)*ones(1,s1(x)),find(s1>0),'UniformOutput',false);
    y = cat(1,y{:});
end
