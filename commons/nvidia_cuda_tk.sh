echo "------------------------------------------------------------------------------------------------------"
echo " BEGIN: nvidia_cuda_tk.sh"
echo "------------------------------------------------------------------------------------------------------"

. ${disk_mnt_point}/tmp/source_urls.sh

# Install repo packages
wget -nv ${NVIDIA_CUDA_TK_URL} -O ${disk_mnt_point}/tmp/${NVIDIA_CUDA_TK} && sudo dpkg -i ${disk_mnt_point}/tmp/${NVIDIA_CUDA_TK}
#wget -nv ${NVIDIA_CUDA_TK_URL} -O ${disk_mnt_point}/tmp/${NVIDIA_CUDA_TK} && sudo dpkg -i ${disk_mnt_point}/tmp/${NVIDIA_CUDA_TK} && rm -f ${disk_mnt_point}/tmp/${NVIDIA_CUDA_TK} 

sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub 

# Download new list of packages
sudo apt-get -y update

sudo apt-get -y install cuda-toolkit-10-0

# Post-installation Actions
cd ${HOME}
echo "export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:${LD_LIBRARY_PATH}" | sudo tee --append /etc/profile.d/cudatk10.sh
echo "export PATH=/usr/local/cuda-10.0/bin:${PATH}" | sudo tee --append /etc/profile.d/cudatk10.sh

echo " END: nvidia_cuda_tk.sh ------------------------------------------------------------------------------"
