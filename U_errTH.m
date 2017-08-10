function dd = U_errTH(fn,opt)
a=textread(fn,'%s','delimiter','\n');
switch opt
case 1 % train
    bb=cellfun(@(x) numel(strfind(x,'Top1-')),a);
    a2= a(bb==1);

    dd=cellfun(@(x) str2num(x(find(x=='%',1,'last')+3:find(x=='L',1,'last')-2)),a2);

    %sc= squeeze(mean(reshape(dd,100,10,[]),1));
    %plot(sc(:))

    %saveas(gcf,'train_err.png')
case 2 % test
    bb=cellfun(@(x) numel(strfind(x,'TESTING SUMMARY')),a);
    a2= a(bb==1);
    %cc=cellfun(@(x) x(1:end-1),a2,'UniformOutput',false);
    dd=cellfun(@(x) str2num(x(end-7:end)),a2);
    %sc=dd;
    %saveas(gcf,'test_err.png')
end
