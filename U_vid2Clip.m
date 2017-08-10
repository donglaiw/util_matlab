function U_vid2Clip(Dvid,Dclip,fn,opt)

% for google cooking data
if ~exist('opt','var');opt=0;end
fr=15;
% fn: in the form of "brush/bit_7u7Pcdyp8rY_400889"
pid= find(fn=='_',1,'last');
vid = fn(pid-11:pid-1);
tt = str2num(fn(pid+1:end))+opt;

load('gcook_vid2Folder.mat','gg')
vn = [Dvid sprintf('%04d/',gg(vid))];
vns=cat(1,dir([vn 'vv' vid '*.mp4']),dir([vn 'vv' vid '*.mkv']));

vv= VideoReader([vn vns(1).name]);
vvF =  vv.FrameRate/fr;
numF = floor(vv.NumberOfFrames/vvF);
ff=min([max(1,floor(tt/1000*fr)) ceil((tt/1000+8)*fr)],numF);
cn =[Dclip fn '/'];
if ~exist(cn,'dir');mkdir(cn);end
    for k=ff(1):ff(2)
        ffn = [sprintf('%05d.jpg',k)];
        if ~exist([cn ffn],'file')%copyfile([Dtmp ffn],[cn ffn]);
            imwrite(read(vv,round(k*vvF)),[cn ffn]);
            pause(1)
        end
    end
end

