function [b0,mm]=U_getMask2(im,bid,bbc,ballR,ballRc,ballM)
b0=-ones(1,4);
sz= size(im);
cmap= rgb2hsv(im);
rr=-ballR:ballR;
rrc=-ballRc:ballRc;
% abs coord
ind={bbc(1)+rr,bbc(2)+rr};
indc={bbc(1)+rrc,bbc(2)+rrc};

% bd effect
for k=1:2;
    ind{k}=ind{k}(ind{k}>0&ind{k}<sz(k)+1);
    indc{k}=indc{k}(indc{k}>0&indc{k}<sz(k)+1);
end

% rgb good for bg
mm = U_getMaskC(im(ind{1},ind{2},:),bid);

aa=bwlabel(mm);
% assume center is right
% guaranteed 
tmp= aa(indc{1}-ind{1}(1)+1,indc{2}-ind{2}(1)+1);

lid=1:max(tmp(:));cc=histc(tmp(:),lid);
cc(cc>ballM)=0;%size
[~,cid]=max(cc);
lid=lid(cid);

if nnz(ismember(tmp,lid))<10;lid=[];end
% center is blank
if isempty(lid);
    lid=1:max(aa(:));cc=histc(aa(:),lid);
    cc(cc>ballM)=0;
    [~,cid]=max(cc);lid=lid(cid);
end
if ~isempty(lid)
    % naive bd
    [tx,ty] = ind2sub(size(aa),find(aa==lid));
    b00 = [min(tx) max(tx) min(ty) max(ty)];
    % prune by density
    for k=1:2
        br=b00(1):b00(2);aa(br(sum(aa(br,:),2)==1),:)=0;
        br=b00(3):b00(4);aa(:,br(sum(aa(:,br))==1))=0;
    end
    if nnz(aa==lid)>0
        [tx,ty] = ind2sub(size(aa),find(aa==lid));
        b00 = [min(tx) max(tx) min(ty) max(ty)];
        % global frame: bd effect
        b0=[b00(1:2)+(ind{1}(1)-1) b00(3:4)+(ind{2}(1)-1)];
        mm=mm((b0(1):b0(2))-ind{1}(1)+1,(b0(3):b0(4))-ind{2}(1)+1);
    end
end
