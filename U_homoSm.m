function hh2 = U_homoSm(hh,th1,th2)
        % add middle point
        sz=size(hh,1);
        static=[reshape(eye(3),1,[]) 0,0];
        hh=[hh(1:sz/2,:);static;hh(1+sz/2:end,:)];
        hh2=hh;

        % find possible bad point
        % use scale: translation is sensative
        d0=max(abs(hh(1:end-1,[1 5])-hh(2:end,[1 5])),[],2);
        bb=find(max(abs(hh(1:end-1,[1 5])-hh(2:end,[1 5])),[],2)>th2)';
        % det >0
        d1 = [arrayfun(@(x) det(reshape(hh(x,1:9),[3,3])),1:sz+1)];
        bb0 = unique([find(hh(:,end-1)'>th1) find(d1<=0)]);
        bb=unique([bb bb+1 bb0]);
        bb=setdiff(bb,sz);
        gg=setdiff(1:sz+1,bb);

        % rescue good point in between but not bb0
        cc=find(gg(2:end)-gg(1:end-1)>1);
        for i=cc
            dis=max(max(abs(bsxfun(@minus,repmat(hh(gg(i)+1:gg(i+1)-1,[1,5]),[1,1,2]),reshape(hh(gg(i:i+1),[1,5])',1,2,2))),[],3),[],2);
            gg=[gg gg(i)+find(dis'<th2)];
        end
        gg=sort(gg);
        if gg(1)~=1
            dis=max(abs(bsxfun(@minus,hh(1:gg(i)-1,[1,5]),hh(gg(i),[1,5]))),[],2);
            gg=[find(dis'<th2) gg];
        end
        if gg(end)~=sz+1
            dis=max(abs(bsxfun(@minus,hh(gg(end)+1:end,[1,5]),hh(gg(end),[1,5]))),[],2);
            gg=[gg gg(end)+find(dis'<th2)];
        end
        gg=setdiff(gg,bb0);

        % do interp
        cc2=find(gg(2:end)-gg(1:end-1)>1);
        for i=cc2
            ind=gg(i+(0:1));
            num=ind(2)-ind(1);
            H1=reshape(hh(ind(1),1:9),[3,3]);
            H2=reshape(hh(ind(2),1:9),[3,3]);
            for j=1:num-1
                h0=expm(j/num*logm(H2)+(num-j)/num*logm(H1));
                hh2(j+ind(1),1:9)=reshape(h0,1,[]);
            end
        end
        
        % need extrapolation
        if gg(1)~=1
            hh2(1:gg(1)-1,:)=repmat(hh(gg(1),:),gg(1)-1,1);
        end
        if gg(end)~=sz+1
            hh2(gg(end)+1:end,:)=repmat(hh(gg(end),:),sz+1-gg(end),1);
        end

        hh2(sz/2+1,:)=[];
