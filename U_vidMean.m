function y=U_vidMean(fn,pf,indF,sf,numD,col)
if ~exist('sf','var');sf='jpg';end
if ~exist('numD','var') || isempty(numD);numD='04';end
if ~exist('indF','var') || isempty(indF);indF=1:numel(dir([fn '/' pf '*.' sf]));end
if ~exist('col','var');col=[];end

y=zeros(size(imread([fn sprintf(['/' pf '%' numD 'd.' sf],indF(1))]),3),numel(indF),'uint8');

if isempty(col)
    parfor j=1:numel(indF)
        % make sure it's 8 bit ...
        y(:,j) = squeeze(mean(mean(255*im2single(imread([fn sprintf(['/' pf '%' numD 'd.' sf],indF(j))])),1),2));
    end
else
    parfor j=1:numel(indF)
        % make sure it's 8 bit ...
        tmp = 255*im2single(imread([fn sprintf(['/' pf '%' numD 'd.' sf],indF(j))]));
        y(:,j) = squeeze(mean(mean(tmp(:,col(1):col(2),:),1),2));
    end
end

