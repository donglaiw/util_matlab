function out = U_montage(ims,num_row,num_col)
sz= size(ims);
out=zeros([num_row*sz(1),num_col*sz(2), sz(3)]);
for i=1:size(ims,4)
   cid = floor((i-1)/num_row); 
   rid = i-cid*num_row; 
   out((rid-1)*sz(1)+(1:sz(1)),cid*sz(2)+(1:sz(2)),:) = ims(:,:,:,i);
end
