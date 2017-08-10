function y=U_findpeak(arr,step)
if numel(arr)<=1;y=arr;return;end

y=arr(1);
out=[1];
while numel(out)>0
    out = find(arr>=y(end)+step,1,'first');
    y=[y arr(out)];
end
% test cases
% U_findpeak([1,3,10,15,16,29],5)
