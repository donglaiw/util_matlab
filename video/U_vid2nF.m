function y=U_vid2nF(vn)
FFM='ffprobe ';
[~,y]=system([FFM '-select_streams v -show_streams ' vn ' 2>/dev/null | grep nb_frames | sed -e ''s/nb_frames=//''']);
if numel(strfind(y,'N/A'))>0
    % not directly available
    [~,num]=system([FFM '-show_format ' vn ' 2>&1 | grep duration']);
    numT=str2num(num(find(num=='=')+1:end));
    [~,tmp]=system([FFM '-i ' vn]);
    out=strfind(tmp,'fps');
    fps = str2num(tmp(out-find(tmp(out:-1:1)==',',1,'first')+2:out-1));

    y=numT*fps;
else
    % multiple streams
    y = [cellfun(@(x) str2num(x),strsplit(y,'\n'),'UniformOutput',false)];
    y = max(cat(2,y{:}));
    if isempty(y);y=0;end
end
