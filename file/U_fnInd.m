function [y,xid]=U_fnInd(x,key)
if ~exist('key','var');key='.';end
% xx.mov.part also works
xid = find(x==key,1,'first');
if isempty(xid)
    y = [x(end) '/' x(end-1) '/' x];
    xid = numel(x);
else
    xid=xid-1;
    y = [x(xid) '/' x(xid-1) '/' x];
end
