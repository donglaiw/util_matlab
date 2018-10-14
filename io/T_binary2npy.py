import caffe
import numpy as np
import sys
# python T_binary2npy.py /data/vision/billf/donglai-lib/VisionLib/Donglai/DeepL/cxxnet/caffe/data/ilsvrc12/imagenet_mean.binaryproto out.npy
if len(sys.argv) != 3:
    print "Usage: python convert_protomean.py proto.mean out.npy"
    sys.exit()

blob = caffe.proto.caffe_pb2.BlobProto()
data = open( sys.argv[1] , 'rb' ).read()
blob.ParseFromString(data)
arr = np.array( caffe.io.blobproto_to_array(blob) )
out = arr[0]
import pdb; pdb.set_trace()
np.save( sys.argv[2] , out )
