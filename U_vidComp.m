function U_vidComp(v1,v2,opt)
video1=VideoReader(v1);
video2=VideoReader(v2);

duracion=max(video1.NumberOfFrames,video2.NumberOfFrames);

figure(1);clf
for x=1:duracion
    switch opt
    case 0
        % side-by-side
        if x<=video1.NumberOfFrames
            subplot(121)
            imshow(video1.read(x));
            drawnow
        end
        if x<=video2.NumberOfFrames
            subplot(122)
            imshow(video2.read(x));
            drawnow
        end
    case 1
        if x<=video1.NumberOfFrames && x<=video2.NumberOfFrames
            im1 = rgb2gray(video1.read(x));
            sz = size(im1);
            im2 = imresize(rgb2gray(video2.read(x)),sz);
            imshow(cat(3,im1,im2,zeros(sz,'uint8')));
            drawnow
        end
    end
end
