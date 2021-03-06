function out = U_getMask(cmap,opt,ran,mask,bran)
if ~exist('bran','var');bran=[];end
switch opt
case 1
    mTable = cmap(:,:,1)>100/255&cmap(:,:,2)>85/255&cmap(:,:,3)>100/255;
    [a,b]=bwlabel(mTable);
    [count,sid]=sort(histc(a(:),1:b),'descend');
    c=sid(1);
    if b>1 && count(2)>count(1)*0.2
        c=sid(1:2);
    end
    %out = bwconvhull(ismember(a,c));
    out = imfill(ismember(a,c),'holes'); % count overlap
case 2
    %mask = imfill(ismember(a,c),'holes');
    if ~isempty(bran) % remove bg [not that useful]
        tmp=mask;
        for j=1:3
            tmp=tmp&cmap(:,:,j)>bran(j*2-1)&cmap(:,:,j)<bran(j*2);
        end
    end
    % find ball
    out=cell(1,3);% w,o,r
    for i=1:3
        out{i} = mask;
        for j=1:3
            out{i}=out{i}&cmap(:,:,j)>ran{i}(j*2-1)&cmap(:,:,j)<ran{i}(j*2);
        end
    end
    %{
    % white: [0,0,255-k]-[255,k,255]
    out{1}=cmap(:,:,1)>20/255&cmap(:,:,1)<150/255&cmap(:,:,2)>10/255&cmap(:,:,2)<120/255&mask;
    % orange: [0,0,255-k]-[255,k,255]
    out{2}=cmap(:,:,1)<30/255&cmap(:,:,2)>80/255&cmap(:,:,3)>100/255&mask;
    % red: H:[0-10,160-180/180] 
    out{3}=cmap(:,:,1)>170/255&cmap(:,:,2)>80/255&mask;
    %}
    % hard to separate white
    out{1} = out{1}&(~out{2})&(~out{3});
    %out{4}=out{1}|out{2}|out{3};
end
