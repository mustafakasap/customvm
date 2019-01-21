echo "------------------------------------------------------------------------------------------------------"
echo " nvidia_nccl.sh"
echo "------------------------------------------------------------------------------------------------------"

. ${disk_mnt_point}/tmp/source_urls.sh

# Install repo packages
wget -nv ${NVIDIA_NCCL_URL} -O ${disk_mnt_point}/tmp/${NVIDIA_NCCL} && sudo dpkg -i ${disk_mnt_point}/tmp/${NVIDIA_NCCL}
#wget -nv ${NVIDIA_NCCL_URL} -O ${disk_mnt_point}/tmp/${NVIDIA_NCCL} && sudo dpkg -i ${disk_mnt_point}/tmp/${NVIDIA_NCCL} && rm -f ${disk_mnt_point}/tmp/${NVIDIA_NCCL} 

# Download new list of packages
sudo apt-get -y update

sudo apt install -y libnccl2 libnccl-dev

echo "----------------------------------------------END nvidia_nccl.sh--------------------------------------"
