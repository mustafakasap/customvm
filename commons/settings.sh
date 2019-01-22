#!/bin/sh

# Define several global variables to be used for setting the DSVM properties
echo "------------------------------------------------------------------------------------------------------"
echo " Setting general script parameters"
echo "------------------------------------------------------------------------------------------------------"

# Update following path with the current script's path on your machine
# i.e. this azure_settings.sh) located as /Users/mkasap/Documents/git/dsvm/settings.sh
#scripts_path=/Users/mkasap/Documents/git/dsvm/azure/
scripts_path=/mnt/d/git/dsvm/azure/


# Resource names (i.e. VM, storage) constructed from resource_name and suffix parameters
# i.e. VM Name = resource_name+suffix
suffix="38"

# Remote command call
function rcc {
   ssh -i ~/.ssh/$vm_name"_id_rsa" $user_name@$vm_dns_name 'bash -s ' < $1
}

function rsc {
   ssh -i ~/.ssh/$vm_name"_id_rsa" $user_name@$vm_dns_name disk_mnt_point=$disk_mnt_point 'bash -s ' < $script_path$1
}

echo "----------------------------------------------END general script parameters---------------------------"
