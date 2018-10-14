function y=U_vid2fps(vn)
    %[~,info]=system(['ffmpeg -i ' vn]);
    [~,info]=system(['ffprobe -i ' vn]);
    ind2 = strfind(info,' fps,')-1;
    ind1 = find(info(ind2:-1:1)==' ',1,'first')-1;
    y= str2num(info(ind2-ind1:ind2));

