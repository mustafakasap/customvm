#!/bin/sh

echo "------------------------------------------------------------------------------------------------------"
echo " mount_disk.sh"
echo "------------------------------------------------------------------------------------------------------"

echo "n
p
1


w" | sudo fdisk "${disk_dev_name}"

partition=$(sudo fdisk -l ${disk_dev_name} | grep -A 1 Device | tail -n 1 | awk '{print $1}')

sudo mkfs -j -t ext4 ${partition}

read uuid fs_type < <(sudo blkid -u filesystem ${partition} | awk -F "[= ]" '{print $3" "$5}' | tr -d "\"")

sudo mkdir ${disk_mnt_point}
sudo chmod 777 ${disk_mnt_point}
sudo chown root ${disk_mnt_point}

fstab_line="UUID=${uuid}\t${disk_mnt_point}\text4\tnoatime,nodiratime,nodev,noexec,nosuid\t1 2"
sudo sh -c "echo '${fstab_line}' >> /etc/fstab"

sudo mount -o exec UUID=${uuid} ${disk_mnt_point}

sudo chmod 777 ${disk_mnt_point}

mkdir ${disk_mnt_point}/tmp
sudo chmod 777 ${disk_mnt_point}/tmp

echo "----------------------------------------------END mount_disk.sh---------------------------------------"
