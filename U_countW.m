function cc=U_countW(fn,ww)
% avoid using bash to do 'wc -l'
fid = fopen(fn);
cc=0;
tline = fgetl(fid);
while ischar(tline)
    if strcmp(ww,tline);cc=cc+1;end
    tline = fgetl(fid);
end
fclose(fid);
