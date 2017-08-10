function vv=U_getM(opt,check)
if ~exist('check','var');check=0;end
bb=[23,26];

v1=arrayfun(@(x) sprintf('vision%02d',x),setdiff(1:38,bb),'UniformOutput',false);
v2=arrayfun(@(x) sprintf('visiongpu%02d',x),1:11,'UniformOutput',false);
v3=arrayfun(@(x) sprintf('visiongpu%02dbill',x),12:14,'UniformOutput',false);
v4={'monday','tuesday','thursday','friday','saturday'};
v5={'asia','africa','america','europe','antarctica','australia'};
v6={'wednesday','tango','rumba','swing'};

switch opt
case 1
    % all
    vv=cat(2,v1,v2,v3,v4,v5,v6);
case 2
    % visions
    vv=v1;
case 3
    % rest
   vv=cat(2,v2,v3,v4,v5,v6);
case 4
    % all but gpu
    vv=cat(2,v1,v4,v5,v6);
case 5
    % gpu
    vv=cat(2,v2,v3);
case 6
    vv=cat(2,v6);
end

switch check
case 1
    % check vimeo
    PP='/scratch/donglai/';
    PP='/data/vision/billf/deep-time/Data/vimeo/dw/tmp/';
    cc=zeros(1,numel(vv));
    aa=0;
    for vid=1:numel(vv)
        vn=vv{vid};
        sn = [PP 't_' num2str(vid) '.txt']; 
        cmd=['timeout 5 ssh ' vn ' "/data/vision/billf/donglai-lib/bin/youtube-dl  --no-overwrites --continue -F http://vimeo.com/12847386 >' sn '"'];
        [~,tmp]=system([cmd]);
        if exist(sn,'file')
            [~,tmp]=system(['tail -n 1 ' sn]);
            if numel(strfind(tmp,'HTTP'))==0
                cc(vid)=1;
                aa=aa+1;
                fprintf('get %d: %s\n',aa,vn);
            end
            delete(sn)
        end
    end
    vv=vv(cc==1);
    fprintf('%d machines found\n',numel(vv));
end
