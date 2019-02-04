#!/bin/sh

echo "------------------------------------------------------------------------------------------------------"
echo " BEGIN: azure_create_disk.sh"
echo "------------------------------------------------------------------------------------------------------"

# --sku {Premium_LRS, Standard_LRS}]
# az disk create -n "$disk_name" -g "$resource_group_name" -l "$res_location" --tags "$resource_tags" --size-gb 1000 --sku Standard_LRS
az disk create \
		-n "$disk_name" \
		-g "$resource_group_name" \
		-l "$resource_location" \
		--tags "$resource_tags" \
		--size-gb $disk_size  \
		--sku Standard_LRS


#az vm disk attach -g "$resource_group_name" --vm-name "$vm_name" --disk "$disk_name"
az vm disk attach \
		-g "$resource_group_name" \
		--vm-name "$vm_name" \
		--disk "$disk_name"

# partition, label and mount the newly created disk
echo "Partitioning and mounting the extra disk."
ssh -i ~/.ssh/$vm_name"_id_rsa" $user_name@$vm_dns_name disk_dev_name=$disk_dev_name disk_mnt_point=$disk_mnt_point 'bash -s ' < $script_path"../commons/mount_disk.sh"

echo " END: azure_create_disk.sh ---------------------------------------------------------------------------"
