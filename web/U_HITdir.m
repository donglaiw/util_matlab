function U_HITdir(DDo)
    DDv='/data/vision/billf/deep-learning/Manipulation/www/';
    U_mkdir(DDo);
    U_mkdir([DDo 'test']);
    U_mkdir([DDo 'saved']);
    system(['chmod 777 ' DDo 'saved']);
    system(['cp ' DDv 'HITs_vimeo/save_ans.php ' DDo]);

