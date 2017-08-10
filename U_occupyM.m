% input: nids
% addpath('../util/');nids=0:3;U_occupyM;
DD0='/data/vision/billf/deep-time/Data/vimeo/';
    addpath('/data/vision/billf/donglai-lib/VisionLib/Donglai/DeepL/caffe_action/matlab')
    caffe.reset_all();caffe.set_mode_gpu();
    for nid=nids
        caffe.set_device(nid);
        net = caffe.Net([DD0 'model/TA/vgg_flo20_deploy_fc_1scale_para2.prototxt'],[DD0 'snapshot/TA/vgg_split1_flo20A_fc05_1scale_para_sp_iter_20000.caffemodel'], 'test');
        net.forward({rand(224,224,20,150)});
    end
