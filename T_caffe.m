switch tid
case 1
    % create mean image for caffe flow
    D0='/data/vision/billf/donglai-lib/VisionLib/Donglai/DeepL/caffe_action/scripts/';
    data=128*ones([1,3,227,227],'single');
    %data(:,end,:,:)=0;
    save([D0 'flow_mean128.mat'],'data')
    % cd /data/vision/billf/donglai-lib/VisionLib/Donglai/DeepL/caffe_action/scripts
    % python T_mat2binary.py flow_mean128.mat flow_mean128.binaryproto
    % test:
    % python T_binary2npy.py im_meanVgg.binaryproto tmp.npy
case 2
    % create mean image for caffe flow
    D0='../util/';
    data = permute(repmat(reshape([103.939, 116.779, 123.68],[1,1,3,1]),[224 224]),[4,3,2,1]);
    %data(:,end,:,:)=0;
    save([D0 'im_meanVgg.mat'],'data')
case 3
    % modify solverstate for new network 
    % combine two solver state
    % cd ../order;
    %addpath('../util');tid=3;T_caffe
    addpath('/data/vision/billf/donglai-lib/VisionLib/Donglai/DeepL/caffe_action/matlab')
    caffe.set_mode_gpu();caffe.set_device(1);
    D0='/data/vision/billf/deep-learning/Manipulation/order/';
    net = caffe.Net([D0 'model/order_m8F_deploy_grill.prototxt'],[D0 'snapshot/order_m8F_init_iter_1.caffemodel'], 'test');
    
    DD = '/data/vision/billf/donglai-lib/VisionLib/Donglai/DeepL/visualneuron/';
    netVGG = caffe.Net([DD 'models/caffe_model_def/deploy_vgg16_imagenet_p5.prototxt'],[DD 'models/caffe_model//VGG_ILSVRC_16_layers.caffemodel'], 'test');
    
    nns ={'conv1_1','conv1_2','conv2_1','conv2_2','conv3_1','conv3_2','conv3_3','conv4_1','conv4_2','conv4_3','conv5_1','conv5_2','conv5_3'}; 
    for nid=1:numel(nns)
        for wid=1:2
            tmp = netVGG.layer_vec( netVGG.name2layer_index(nns{nid})).params(wid).get_data();
            % old two network weight
            %for tt=1:2;net.params([nns{nid} '_' num2str(tt)], wid).set_data(tmp); end
            net.params(nns{nid}, wid).set_data(tmp);
        end
    end
    net.save([D0 'snapshot/order_m8F_init_VGG.caffemodel']);

    %s1 = caffe.Solver([D0 'order/model/order_m8F_solver_init2.prototxt']);
    %s1.restore([D0 'order/snapshot/order_m8F_init_iter_1.solverstate']);
case 3.1
    addpath('/data/vision/billf/donglai-lib/VisionLib/Donglai/DeepL/caffe_action/matlab')
     caffe.set_mode_gpu();caffe.set_device(1);
    D0='/data/vision/billf/deep-learning/Manipulation/order/';
    s1 = caffe.Solver([D0 'model/order_m8F_solver_init2.prototxt']);
    s1.restore([D0 'snapshot/order_m8F_init_iter_1.solverstate']);

case 4
    % test initialization
    addpath('/data/vision/billf/donglai-lib/VisionLib/Donglai/DeepL/caffe_action/matlab')
    caffe.set_mode_gpu();caffe.set_device(1);
    D0='/data/vision/billf/deep-learning/Manipulation/order/';
    n1 = caffe.Net([D0 'model/order_m8F_deploy_init_p5.prototxt'],[D0 'snapshot/order_m8F_init_VGG.caffemodel'], 'test');
    n2 = caffe.Net([D0 'model/order_m8F_deploy_init.prototxt'],[D0 'snapshot/order_m8F_init_VGG.caffemodel'], 'test');
    
    DD = '/data/vision/billf/donglai-lib/VisionLib/Donglai/DeepL/visualneuron/';
    nV = caffe.Net([DD 'models/caffe_model_def/deploy_vgg16_imagenet_p5.prototxt'],[DD 'models/caffe_model//VGG_ILSVRC_16_layers.caffemodel'], 'test');

    d=single(rand([224 224 3]));
    rV = nV.forward({d});
    r1 = n1.forward({cat(3,d,d)});
    nnz(r1{1}(:)-r1{2}(:))
    nnz(r1{1}(:)-rV{1}(:))
    % Nconv1 param
    aa=n2.layer_vec(67).params(1).get_data();
case 5
    % truncate saved solverstate for easier evaluation
    % combine two solver state
    % cd ../order;
    %addpath('../util');tid=3;T_caffe
    addpath('/data/vision/billf/donglai-lib/VisionLib/Donglai/DeepL/caffe_action/matlab')
    caffe.set_mode_gpu();caffe.set_device(1);
    D0='/data/vision/billf/deep-learning/Manipulation/order/';
    nns={'pour','sprinkle','spread','stir','cut','peel','crack','mash','fold','knead','squeeze','rub','scoop','dip','boil','fry','grill'};
    nid=1;
    nn = nns{nid};
    net = caffe.Net([D0 'model/order_m8F_deploy_' nn '.prototxt'],[D0 'snapshot/order_m8F_' nn '_iter_18000.caffemodel'], 'test');
    
    netP5 = caffe.Net([D0 'model/order_m8_deploy-2_1024.prototxt'],[D0 'snapshot/order_m8_' nn '_iter_20000.caffemodel'], 'test');
    
    nns ={'conv1','conv2'}; 
    for nid=1:numel(nns)
        for wid=1:2
            tmp = net.layer_vec( net.name2layer_index(['N' nns{nid}])).params(wid).get_data();
            tmp2 = netP5.layer_vec( netP5.name2layer_index([nns{nid}])).params(wid).get_data();
            % old two network weight
            %for tt=1:2;net.params([nns{nid} '_' num2str(tt)], wid).set_data(tmp); end
            netP5.params(nns{nid}, wid).set_data(reshape(tmp,size(tmp2)));
        end
    end
    netP5.save([D0 'snapshot/order_m8F_' nn '_iter18000_trunc.caffemodel']);


end
