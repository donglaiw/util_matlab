function hh=U_vid2Height(Dout,fn)
% faster way to get video size, instead of VideoReader
FFM='~/soft/bin/ffmpeg ';
[~,hh] = system([FFM '-i "' Dout fn '" | grep Video']);
if strfind(hh,'not found')
    % need to redownload the video
    disp(['not found: ' fn])
    movefile([Dout fn],[Dout 'b_' fn]);
    hh=-1;
    return
else
    if strcmp(fn(end-2:end),'mp4') || strcmp(fn(end-3:end),'webm')
        hid = strfind(hh,'yuv');
    else
        hid = strfind(hh,'Video');
    end
    if numel(hid)==0
        disp(['bad: ' fn])
        movefile([Dout fn],[Dout 'b_' fn]);
        hh=-1;
        return
    end
    hh=hh(hid(1):end);
    hid=find(hh=='x',1,'first');hh=hh(hid(1):end);
    hh=str2num(hh(2:find(hh==' ',1,'first')));
end

