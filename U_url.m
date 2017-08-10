function y=U_url(x)
    y = strrep(x,'#','%23');
    y = strrep(y,'(','%28');
    y = strrep(y,')','%29');
    y = strrep(y,'!','%21');
    y = strrep(y,'-','%2D');
end
