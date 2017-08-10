function density=U_heatmap(points,grid,xran,yran)
if numel(grid)==1;grid=[grid grid];end
if ~exist('xran','var');xran=[min(points(:,1)) max(points(:,1))];end
if ~exist('yran','var');yran=[min(points(:,2)) max(points(:,2))];end

xidx = 1 + round((points(:,1) - xran(1)) ./ (xran(2)-xran(1)) * (grid(2)-1));
yidx = 1 + round((points(:,2) - yran(1)) ./ (yran(2)-yran(1)) * (grid(1)-1));
density = accumarray([yidx, xidx], 1, [grid(1),grid(2)]);  %note y is rows, x is cols
%imagesc(density, 'xdata', [xran(1), xran(2)], 'ydata', [yran(1), yran(2)]);
