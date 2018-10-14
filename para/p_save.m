function p_save(fn,sn,data)
eval([sn '=data;']);
save(fn,sn,'-v7.3')
