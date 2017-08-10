function vn=U_fn(vn)
vn = strrep(strrep(vn,'(','\('),')','\)');
vn = strrep(strrep(vn,'[','\['),']','\]');
vn = strrep(vn,';','\;');
vn = strrep(vn,'!','\!');

