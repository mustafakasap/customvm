echo "------------------------------------------------------------------------------------------------------"
echo " BEGIN: nvidia_cudnn.sh"
echo "------------------------------------------------------------------------------------------------------"

. ${disk_mnt_point}/tmp/source_urls.sh

# Install repo packages
wget -nv ${NVIDIA_CUDNN_RUNTIME_URL} -O ${disk_mnt_point}/tmp/${NVIDIA_CUDNN_RUNTIME} && sudo dpkg -i ${disk_mnt_point}/tmp/${NVIDIA_CUDNN_RUNTIME}
wget -nv ${NVIDIA_CUDNN_DEV_URL} -O ${disk_mnt_point}/tmp/${NVIDIA_CUDNN_DEV} && sudo dpkg -i ${disk_mnt_point}/tmp/${NVIDIA_CUDNN_DEV}
wget -nv ${NVIDIA_CUDNN_DOC_URL} -O ${disk_mnt_point}/tmp/${NVIDIA_CUDNN_DOC} && sudo dpkg -i ${disk_mnt_point}/tmp/${NVIDIA_CUDNN_DOC}

#wget -nv ${NVIDIA_CUDNN_RUNTIME_URL} -O ${disk_mnt_point}/tmp/${NVIDIA_CUDNN_RUNTIME} && sudo dpkg -i ${disk_mnt_point}/tmp/${NVIDIA_CUDNN_RUNTIME} && rm -f ${disk_mnt_point}/tmp/${NVIDIA_CUDNN_RUNTIME} 
#wget -nv ${NVIDIA_CUDNN_DEV_URL} -O ${disk_mnt_point}/tmp/${NVIDIA_CUDNN_DEV} && sudo dpkg -i ${disk_mnt_point}/tmp/${NVIDIA_CUDNN_DEV} && rm -f ${disk_mnt_point}/tmp/${NVIDIA_CUDNN_DEV} 
#wget -nv ${NVIDIA_CUDNN_DOC_URL} -O ${disk_mnt_point}/tmp/${NVIDIA_CUDNN_DOC} && sudo dpkg -i ${disk_mnt_point}/tmp/${NVIDIA_CUDNN_DOC} && rm -f ${disk_mnt_point}/tmp/${NVIDIA_CUDNN_DOC} 

echo " END: nvidia_cudnn.sh --------------------------------------------------------------------------------"
