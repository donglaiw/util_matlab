function U_plot(ims)
num = ceil(sqrt(numel(ims)));
for i=1:numel(ims)
    subplot(num,num,i)
    imagesc(ims{i})
end
