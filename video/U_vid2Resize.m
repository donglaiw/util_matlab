function U_vid2Resize(Dout,fn)
FFM='~/soft/bin/ffmpeg ';
system([FFM '-y -i "' Dout fn '" -vcodec libx264 -pix_fmt yuv420p -profile:v baseline -vf "scale=trunc(in_w/in_h*128)*2:256" -preset veryslow -an "' Dout 'v' fn '" 2> /dev/null']);
delete([Dout fn])
movefile([Dout 'v' fn],[Dout fn])
