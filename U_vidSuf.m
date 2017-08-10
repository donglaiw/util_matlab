function [y,iv]=U_vidSuf(vn,vv);

[~,iv] = ismember(vn,cellfun(@(x) x(1:find(x=='.',1,'first')-1),vv,'UniformOutput',false));
%keyboard
%[~,iv] = intersect(cellfun(@(x) x(1:find(x=='.',1,'first')-1),vv,'UniformOutput',false),vn);
y=vv(iv(iv>0));
