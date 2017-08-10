function y =U_codec(fn,st)
if ~exist('st','var');st=' ';end
        y = ' ';
        [~,line]=system(['ffprobe -i ' fn]);
        tmp=regexp(line, 'Video: ', 'split');
        if numel(tmp)>1
            y = tmp{2}(1:find(tmp{2}==st,1,'first')-1);
        end

