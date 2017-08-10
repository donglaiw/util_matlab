function para = U_para(opt)
switch opt
case 1
    % flow param
    alpha = 0.01;
    ratio = 0.5;
    minWidth = 10;
    nOuterFPIterations = 7;
    nInnerFPIterations = 1;
    nSORIterations = 30;
    para = [alpha,ratio,minWidth,nOuterFPIterations,nInnerFPIterations,nSORIterations];
case 2
    para=load('lib/edges/models/forest/modelBsds'); 
    para=para.model;
    para.opts.multiscale=0;
    para.opts.sharpen=2;
    para.opts.nThreads=4;
case 3
    para = edgeBoxes;
    para.alpha = .65;     % step size of sliding window search
    para.beta  = .75;     % nms threshold for object proposals
    para.minScore = .01;  % min score of boxes to detect
    para.maxBoxes = 1e4;  % max number of boxes to detect
    
end


end


