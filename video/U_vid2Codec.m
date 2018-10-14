function out=U_vid2Codec(fn)
% old naive way ... (can't handle multiple streams)
%{
[~,line]=system(['ffprobe -i ' fn]);
tmp=regexp(line, 'Video: ', 'split');
out = ' ';
if numel(tmp)>1
    out = tmp{2}(1:find(tmp{2}==' ',1,'first')-1);
    if out(end)==',';out(end)=[];end
end
%}
[~, out]=system(['ffprobe -select_streams v -v error -show_entries stream=codec_name -of default=noprint_wrappers=1 -i ' fn]);
out= cellfun(@(x) x(find(x=='=',1,'last')+1:end),strsplit(out,' '),'UniformOutput',false);
% the way we download it...
out=out{end}(1:end-1);
