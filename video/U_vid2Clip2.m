function U_vid2Clip2(vn0,cn0,opt)
% for go
if ~exist('opt','var');opt=0;end
Dv = '/data/vision/billf/video-tutorial/data/gdaily/video/';
Dc = '/data/vision/billf/video-tutorial/data/gdaily/clip/';

% U_vid2Clip2('suitcase','BPloIzDa6bg',11)
% U_vid2Clip2('microwave','gSOY-hW5gjQ',6)
vn =  [Dv vn0 '/vv' cn0 '.mp4'];
cn =  [Dc vn0 '/' cn0 sprintf('_%04d/',opt)];


vv= VideoReader(vn);
fps=15;
fps_len=3*3;
fps_nF = fps*fps_len;
vvF =  vv.FrameRate/fps;
numF0 = vv.NumberOfFrames;
numF = floor(numF0/vvF);

ind = (opt-1)*fps_nF+(1:fps_nF);
ind(ind>numF) = [];
tmp=clock;
rng(60*tmp(end-1)+round(tmp(end)));
%rng(12321)
%if(tid==2&&j==2);keyboard;end
keyboard
%for l=ind(randperm(numel(ind)))
% random frame bug...
for l=ind
    ffn = [sprintf('%05d.jpg',l)];
    if 1||~exist([cn ffn],'file')
        % vvF can <1
        imwrite(read(vv,max(1,round(vvF*l))),[cn ffn]);
        %pause(.1)
    end
end
