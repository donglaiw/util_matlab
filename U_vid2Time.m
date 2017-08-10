function numF0 = U_vid2Time(vn)
%{
FFM='~/soft/bin/ffmpeg ';
[~,numF0]=system([FFM '-i ' vn ' 2>&1 | grep "Duration"| cut -d '' '' -f 4 | sed s/,// | sed ''s@\..*@@g'' | awk ''{ split($1, A, ":"); split(A[3], B, "."); print 3600*A[1] + 60*A[2] + B[1]}''']);
%}
FFM='~/soft/bin/ffprobe ';
[~,num]=system([FFM '-show_format ' vn ' 2>&1 | grep duration']);
pause(1)
numF0=str2num(num(find(num=='=')+1:end));
