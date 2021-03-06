#!/bin/sh

# Terminate after the first line that fails (returns nonzero exit code).
# set -e

dos2unix *
dos2unix ../commons/*

# -----------------------------------------------------------------------------------------------------------
# Set Parameters
# -----------------------------------------------------------------------------------------------------------
# Call azure_settings.sh script to set global variables to be used in the upcoming scripts.
. ../commons/settings.sh
. $scripts_path"azure_settings.sh"


# -----------------------------------------------------------------------------------------------------------
# Azure Authentication
# -----------------------------------------------------------------------------------------------------------
# Authenticate this terminal session with Azure, so we will not need to enter password per Azure CLI command
# Check if we are authenticated with Azure or there already exist a session?
az account show &> /dev/null
if [ "$?" != "0" ]; then
	az login | awk '{print $0}' | > /dev/null
fi

# Set default subscription, so resources will be created under this subscription
az account set                                                                                              \
   --subscription $azure_subscription_id


# -----------------------------------------------------------------------------------------------------------
# Create SSH Keys
# -----------------------------------------------------------------------------------------------------------
# Create public/private ssh keys.
yes y | ssh-keygen -b 2048 -t rsa -f ~/.ssh/$vm_name"_id_rsa" -C $user_name@$vm_dns_name -q -N '' >/dev/null

# Remove prev. trusted host with same name (IP may be changed)
if [ -e ~/.ssh/known_hosts ]; then
ssh-keygen -f ~/.ssh/known_hosts -R $vm_dns_name
fi


# -----------------------------------------------------------------------------------------------------------
# Create Azure VM
# -----------------------------------------------------------------------------------------------------------
. $scripts_path"azure_create_vm.sh"

# -----------------------------------------------------------------------------------------------------------
# Create Disk
# -----------------------------------------------------------------------------------------------------------
. $scripts_path"azure_create_disk.sh"


# -----------------------------------------------------------------------------------------------------------
# Copy shell script to remote. Set as executable. It will be used to set temp environment variables
# -----------------------------------------------------------------------------------------------------------
scp -i ~/.ssh/$vm_name"_id_rsa" $scripts_path"../commons/source_urls.sh" $user_name@$vm_dns_name:${disk_mnt_point}/tmp/
ssh -i ~/.ssh/$vm_name"_id_rsa" $user_name@$vm_dns_name "sudo chmod 777 ${disk_mnt_point}/tmp/source_urls.sh"

# -----------------------------------------------------------------------------------------------------------
# Install NVidia Drivers
# -----------------------------------------------------------------------------------------------------------
rsc "../commons/nvidia_driver.sh"

# -----------------------------------------------------------------------------------------------------------
# Install NVidia CUDA Toolkit
# -----------------------------------------------------------------------------------------------------------
rsc "../commons/nvidia_cuda_tk.sh"

# -----------------------------------------------------------------------------------------------------------
# Install NVidia cuDNN
# -----------------------------------------------------------------------------------------------------------
rsc "../commons/nvidia_cudnn.sh"

# -----------------------------------------------------------------------------------------------------------
# Install NVidia NCCL
# -----------------------------------------------------------------------------------------------------------
rsc "../commons/nvidia_nccl.sh"

# -----------------------------------------------------------------------------------------------------------
# Install NVidia TensorRT
# -----------------------------------------------------------------------------------------------------------
rsc "../commons/nvidia_tensorrt.sh"

# -----------------------------------------------------------------------------------------------------------
# Install Dependencies
# -----------------------------------------------------------------------------------------------------------
rsc "../commons/dependencies.sh"

# -----------------------------------------------------------------------------------------------------------
# Install Bazel
# -----------------------------------------------------------------------------------------------------------
rsc "../commons/bazel.sh"

# -----------------------------------------------------------------------------------------------------------
# Install Intel MKL-DNN
# -----------------------------------------------------------------------------------------------------------
rsc "../commons/intel_mkl_dnn.sh"

# -----------------------------------------------------------------------------------------------------------
# Install additional tools
# -----------------------------------------------------------------------------------------------------------
rsc "../commons/tools.sh"

# -----------------------------------------------------------------------------------------------------------
# Install OpenCV
# -----------------------------------------------------------------------------------------------------------
rsc "../commons/opencv_compile.sh"


# -----------------------------------------------------------------------------------------------------------
# Compile & Install Tensorflow
# -----------------------------------------------------------------------------------------------------------
scp -i ~/.ssh/$vm_name"_id_rsa" $scripts_path"../commons/tf_bazel_config.p2" $user_name@$vm_dns_name:${disk_mnt_point}/tmp/
scp -i ~/.ssh/$vm_name"_id_rsa" $scripts_path"../commons/tf_bazel_config.p3" $user_name@$vm_dns_name:${disk_mnt_point}/tmp/
rsc "../commons/tensorflow_compile.sh"

#rsc "../commons/tensorflow_install.sh"