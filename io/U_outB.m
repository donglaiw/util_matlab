function U_outB(fn,vv,pp,sufId)
% write big file

fidO = fopen(fn,'w');
for x=1:numel(vv)
    fprintf(fidO,[vv{x}(1:end-sufId) ' ' num2str(pp(x)) '\n']); 
end
fclose(fidO);
