function y=U_s2uv(pos)
% convert 3-dim coord on sphere to uv map
pos=pos/sqrt(sum(pos.^2));
u=0.5+atan2(pos(3),pos(1))/(2*pi);
v=0.5-asin(pos(2))/pi;
y=[u,v];
