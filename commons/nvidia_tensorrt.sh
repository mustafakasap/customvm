echo "------------------------------------------------------------------------------------------------------"
echo " nvidia_tensorrt.sh"
echo "------------------------------------------------------------------------------------------------------"

. ${disk_mnt_point}/tmp/source_urls.sh

# Install repo packages
wget -nv ${NVIDIA_TENSORRT_URL} -O ${disk_mnt_point}/tmp/${NVIDIA_TENSORRT} && sudo dpkg -i ${disk_mnt_point}/tmp/${NVIDIA_TENSORRT}
#wget -nv ${NVIDIA_TENSORRT_URL} -O ${disk_mnt_point}/tmp/${NVIDIA_TENSORRT} && sudo dpkg -i ${disk_mnt_point}/tmp/${NVIDIA_TENSORRT} && rm -f ${disk_mnt_point}/tmp/${NVIDIA_TENSORRT} 

sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub 

# Download new list of packages
sudo apt-get -y update

sudo apt-get -y install tensorrt

sudo apt-get -y install python-libnvinfer-dev
sudo apt-get -y install python3-libnvinfer-dev
sudo apt-get -y install uff-converter-tf graphsurgeon-tf

echo "----------------------------------------------END nvidia_tensorrt.sh----------------------------------"
