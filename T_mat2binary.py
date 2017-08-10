import caffe
import numpy as np
import sys
import scipy.io


# python T_mat2binary.py /data/vision/billf/donglai-lib/VisionLib/Donglai/DeepL/cxxnet/caffe/scripts/hoho.mat hoho.binaryproto
# python T_mat2binary.py im_meanVgg.mat im_meanVgg.binaryproto
if len(sys.argv) != 3:
    print "Usage: python T_mat2binary.py input.mat output.binaryproto"
    sys.exit()


data = scipy.io.loadmat( sys.argv[1])
#data = scipy.io.loadmat('/data/vision/billf/donglai-lib/VisionLib/Donglai/DeepL/cxxnet/caffe/scripts/hoho.mat')
blob = caffe.io.array_to_blobproto(data['data'])

out = blob.SerializeToString()
ww=open(sys.argv[2] ,'wb')
ww.write( out )
ww.close()
