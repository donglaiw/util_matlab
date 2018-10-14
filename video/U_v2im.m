function U_v2im(DD_in,opt_suf,num_r)
fns = dir([DD_in '*.' opt_suf]);
DD_in = DD_in(1:find(DD_in=='/',1,'last'));
FFM='~/soft/bin/ffmpeg ';
for i=1:numel(fns)
    DD_o = [DD_in fns(i).name(1:end-4) '/'];
    mkdir(DD_o);
    mkdir([DD_o 'im']);
    %v = VideoReader([DD_in fns(i).name]);break
    %system(['ffmpeg -i ' DD_in fns(i).name '  -qscale:v 2 -r ' num2str(num_r) ' ' DD_o 'im/image-%05d.jpg'])
    system([FFM ' -i ' DD_in fns(i).name '  -qscale:v 2 -vf scale=640:-1 -r ' num2str(num_r) ' ' DD_o 'im/image-%05d.jpg'])
    % too small for hand detection
    %system(['ffmpeg -i ' DD_in fns(i).name ' -vf scale=320:-1 -qscale:v 2 -r 10 ' DD_o 'im/image-%03d.jpg'])
    %system(['/afs/csail.mit.edu/u/l/lim/utils/ffmpeg-2.7.2/ffmpeg -i ' fns(i).name ' -r 1 ' DD_o 'image-%03d.jpg'])
end

