function h=V_quiver(flo,ballSpacing,opt)
if ~exist('opt','var');opt=0;end
sz = size(flo);
flo_i = reshape(flo,[],2);

pt_ind=U_gridpt(sz,ballSpacing);
[yy,xx] = meshgrid(1:sz(2),1:sz(1));
xx=flipud(xx);
%flo(:,:,2)=flipud(flo(:,:,2));

if opt==1
    pt_ind = pt_ind(max(abs(flo_i(pt_ind,:)),[],2)>0);
end
pt = [yy(pt_ind),xx(pt_ind)];
h=quiver(pt(:,1),pt(:,2),flo_i(pt_ind,1),flo_i(pt_ind,2),'Color','k','LineWidth',2,'AutoScale','off');
