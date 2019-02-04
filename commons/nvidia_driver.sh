echo "------------------------------------------------------------------------------------------------------"
echo " BEGIN: nvidia_driver.sh"
echo "------------------------------------------------------------------------------------------------------"

. ${disk_mnt_point}/tmp/source_urls.sh

# Install repo packages
wget -nv ${NVIDIA_DRIVER_URL} -O ${disk_mnt_point}/tmp/${NVIDIA_DRIVER} && sudo dpkg -i ${disk_mnt_point}/tmp/${NVIDIA_DRIVER}
#wget -nv ${NVIDIA_DRIVER_URL} -O ${disk_mnt_point}/tmp/${NVIDIA_DRIVER} && sudo dpkg -i ${disk_mnt_point}/tmp/${NVIDIA_DRIVER} && rm -f ${disk_mnt_point}/tmp/${NVIDIA_DRIVER} 

sudo apt-key add /var/nvidia-diag-driver-local-repo-410.79/7fa2af80.pub
#sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub 


# Download new list of packages
sudo apt-get update

: '
    apt-get install cuda - This will install the latest toolkit and the latest driver.
    apt-get install cuda-toolkit-9-2 - Installs only the toolkit and not the driver.
    apt-get install cuda-drivers - Installs only the driver and not the toolkit.
'
# Install just the latest driver (not the TK etc.)
sudo apt-get -y install cuda-drivers

echo " END: nvidia_driver.sh -------------------------------------------------------------------------------"
