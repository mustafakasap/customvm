#!/bin/sh

echo "------------------------------------------------------------------------------------------------------"
echo " Setting source URLs"
echo "------------------------------------------------------------------------------------------------------"


CLOUD_STORAGE_URL=https://xstr.blob.core.windows.net/appstore/

: '
Desc:               NVidia Graphics card driver (VM should have a GPU)
                    Change below NVidia driver according to the GPU type you want to use. Each GPU may require different driver...

                    Tesla Driver with V100 support for Ubuntu 16.04
		
Source URL:         http://www.nvidia.com/Download/index.aspx 
Version: 			410.79
Release Date: 		2018.12.3
Operating System: 	Linux 64-bit Ubuntu 16.04
CUDA Toolkit: 		10.0 (bundled with the driver)
Language: 			English (US)
File Size: 			128.87 MB

Required by:        Tensorflow (GPU version) https://www.tensorflow.org/install/gpu
Why this version:   We download latest driver with latest CTK bundled (which is v10) but we will install just the driver 
                    not the bundled CTK. Specific/required CTK will be installed seperately.
'
NVIDIA_DRIVER=nvidia-diag-driver-local-repo-ubuntu1604-410.79_1.0-1_amd64.deb
NVIDIA_DRIVER_URL=${CLOUD_STORAGE_URL}nvidia/${NVIDIA_DRIVER}


: '
Desc: 	            Cuda Toolkit 10.0
		            https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=deblocal
                    https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html
                    http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/
                    https://developer.nvidia.com/cuda-toolkit-archive
        
Source URL:         https://developer.nvidia.com/cuda-zone
Version: 			10.0
File Size: 			1.6 GB

Required by:        Tensorflow (GPU version) https://www.tensorflow.org/install/gpu
Why this version:   Latest
'
NVIDIA_CUDA_TK=cuda-repo-ubuntu1604-10-0-local-10.0.130-410.48_1.0-1_amd64.deb
NVIDIA_CUDA_TK_URL=${CLOUD_STORAGE_URL}nvidia/${NVIDIA_CUDA_TK}


: '
Desc: 	            cuDNN 7.4.2        
Source URL:         https://developer.nvidia.com/cudnn
Version: 			7.4.2

Required by:        Tensorflow (GPU version) https://www.tensorflow.org/install/gpu
Why this version:   Latest
'
NVIDIA_CUDNN_RUNTIME=libcudnn7_7.4.2.24-1%2Bcuda10.0_amd64.deb
NVIDIA_CUDNN_RUNTIME_URL=${CLOUD_STORAGE_URL}nvidia/${NVIDIA_CUDNN_RUNTIME}
NVIDIA_CUDNN_DEV=libcudnn7-dev_7.4.2.24-1%2Bcuda10.0_amd64.deb
NVIDIA_CUDNN_DEV_URL=${CLOUD_STORAGE_URL}nvidia/${NVIDIA_CUDNN_DEV}
NVIDIA_CUDNN_DOC=libcudnn7-doc_7.4.2.24-1%2Bcuda10.0_amd64.deb
NVIDIA_CUDNN_DOC_URL=${CLOUD_STORAGE_URL}nvidia/${NVIDIA_CUDNN_DOC}


: '
Desc: 	            NVIDIA Collective Communications Library (NCCL)        
Source URL:         https://developer.nvidia.com/nccl
Version: 			2.3.7

Required by:        Tensorflow (GPU version) https://www.tensorflow.org/install/gpu
Why this version:   Latest
'
NVIDIA_NCCL=nccl-repo-ubuntu1604-2.3.7-ga-cuda10.0_1-1_amd64.deb
NVIDIA_NCCL_URL=${CLOUD_STORAGE_URL}nvidia/${NVIDIA_NCCL}


: '
Desc: 	            NVIDIA TensorRT         
Source URL:         https://developer.nvidia.com/tensorrt
Version: 			5.0

Required by:        Tensorflow (GPU version) https://www.tensorflow.org/install/gpu
Why this version:   Latest
'
NVIDIA_TENSORRT=nv-tensorrt-repo-ubuntu1604-cuda10.0-trt5.0.2.6-ga-20181009_1-1_amd64.deb
NVIDIA_TENSORRT_URL=${CLOUD_STORAGE_URL}nvidia/${NVIDIA_TENSORRT}

: '
Desc: 	            Bazel         
Source URL:         https://docs.bazel.build/versions/master/install-ubuntu.html
Version: 			0.21.0

Required by:        Tensorflow (GPU version) https://www.tensorflow.org/install/gpu
Why this version:   Latest
'
BAZEL=bazel_0.21.0-linux-x86_64.deb
BAZEL_URL=${CLOUD_STORAGE_URL}${BAZEL}


: '
Desc: 	            Storage Explorer         
Source URL:         https://docs.bazel.build/versions/master/install-ubuntu.html
Version: 			0.21.0

Required by:        None
Why this version:   Latest
'
STRGEXPL=StorageExplorer-linux-x64.tar.gz
STRGEXPL_URL=${CLOUD_STORAGE_URL}${STRGEXPL}


: '
Desc: 	            OpenCV          
Source URL:         https://opencv.org/
                    https://github.com/opencv/opencv/archive/4.0.0.zip
Version: 			4.0.0

Required by:        None
Why this version:   Latest
'
OPENCV=opencv-4.0.0.zip
OPENCV_URL=${CLOUD_STORAGE_URL}${OPENCV}
OPENCVCONT=opencv_contrib-4.0.0.zip
OPENCVCONT_URL=${CLOUD_STORAGE_URL}${OPENCVCONT}

echo "----------------------------------------------END source URLs-----------------------------------------"
