#!/bin/sh

echo "------------------------------------------------------------------------------------------------------"
echo " Creating Azure VM"
echo "------------------------------------------------------------------------------------------------------"
: '
Desc: 
Prereq:
Ref: 
		https://docs.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest
		https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-deploy-static-pip-arm-cli
'

# Create Resource Group
az group create                                                                                             \
   --name "$resource_group_name"                                                                            \
   --location "$resource_location"                                                                          \
   --tag "$resource_tags"

# Create Storage
az storage account create                                                                                   \
   --name "$storage_account_name"                                                                           \
   --resource-group "$resource_group_name"                                                                  \
   --location "$resource_location"                                                                          \
   --sku Standard_LRS                                                                                       \
   --tags "$resource_tags"                                                                                  \
   --kind Storage

# Create a public IP address resource with a static IP address
az network public-ip create                                                                                 \
   --name "$public_ip_name"                                                                                 \
   --resource-group "$resource_group_name"                                                                  \
   --location "$resource_location"                                                                          \
   --allocation-method Static                                                                               \
   --dns-name "$dns_name"

# Create a virtual network with one subnet
az network vnet create                                                                                      \
   --name "$vnet_name"                                                                                      \
   --resource-group "$resource_group_name"                                                                  \
   --location "$resource_location"                                                                          \
   --address-prefix "$vnet_prefix"                                                                          \
   --subnet-name "$subnet_name"                                                                             \
   --subnet-prefix "$subnet_prefix"

az network nsg create                                                                                       \
   --name "$nsg_name"                                                                                       \
   --resource-group "$resource_group_name"

# Open Jupyter Notebook Port
az network nsg rule create                                                                                  \
   --resource-group "$resource_group_name"                                                                  \
   --nsg-name "$nsg_name"                                                                                   \
   --name "JupyterNotebook"                                                                                 \
   --destination-port-ranges $jnb_port                                                                      \
   --protocol Tcp                                                                                           \
   --access Allow                                                                                           \
   --priority 1010

# Open SSH port
az network nsg rule create                                                                                  \
   --resource-group "$resource_group_name"                                                                  \
   --nsg-name "$nsg_name"                                                                                   \
   --name "Default SSH"                                                                                     \
   --destination-port-ranges $ssh_port                                                                      \
   --protocol Tcp                                                                                           \
   --access Allow                                                                                           \
   --priority 1020

# Create a network interface connected to the VNet with a static private IP address 
# and associate the public IP address resource to the NIC.
az network nic create                                                                                       \
   --name "$nic_name"                                                                                       \
   --resource-group "$resource_group_name"                                                                  \
   --location "$resource_location"                                                                          \
   --subnet "$subnet_name"                                                                                  \
   --vnet-name "$vnet_name"                                                                                 \
   --private-ip-address "$private_ip_address"                                                               \
   --public-ip-address "$public_ip_name"                                                                    \
   --network-security-group "$nsg_name"

# Create the VM
# For image param: Ubuntu 16.04-LTS image -> https://docs.microsoft.com/en-us/azure/virtual-machines/linux/cli-ps-findimage
# Instead of Password login, we are uploading Private SSH key. Update the path accrodingly if needed
: '
Offer          Publisher               Sku                 Urn                                                             UrnAlias             Version
-------------  ----------------------  ------------------  --------------------------------------------------------------  -------------------  ---------
CentOS         OpenLogic               7.5                 OpenLogic:CentOS:7.5:latest                                     CentOS               latest
CoreOS         CoreOS                  Stable              CoreOS:CoreOS:Stable:latest                                     CoreOS               latest
Debian         credativ                8                   credativ:Debian:8:latest                                        Debian               latest
openSUSE-Leap  SUSE                    42.3                SUSE:openSUSE-Leap:42.3:latest                                  openSUSE-Leap        latest
RHEL           RedHat                  7-RAW               RedHat:RHEL:7-RAW:latest                                        RHEL                 latest
SLES           SUSE                    12-SP2              SUSE:SLES:12-SP2:latest                                         SLES                 latest
UbuntuServer   Canonical               16.04-LTS           Canonical:UbuntuServer:16.04-LTS:latest                         UbuntuLTS            latest
WindowsServer  MicrosoftWindowsServer  2019-Datacenter     MicrosoftWindowsServer:WindowsServer:2019-Datacenter:latest     Win2019Datacenter    latest
WindowsServer  MicrosoftWindowsServer  2016-Datacenter     MicrosoftWindowsServer:WindowsServer:2016-Datacenter:latest     Win2016Datacenter    latest
WindowsServer  MicrosoftWindowsServer  2012-R2-Datacenter  MicrosoftWindowsServer:WindowsServer:2012-R2-Datacenter:latest  Win2012R2Datacenter  latest
WindowsServer  MicrosoftWindowsServer  2012-Datacenter     MicrosoftWindowsServer:WindowsServer:2012-Datacenter:latest     Win2012Datacenter    latest
WindowsServer  MicrosoftWindowsServer  2008-R2-SP1         MicrosoftWindowsServer:WindowsServer:2008-R2-SP1:latest         Win2008R2SP1         latest
'
az vm create                                                                                                \
   --name "$vm_name"                                                                                        \
   --resource-group "$resource_group_name"                                                                  \
   --location "$resource_location"                                                                          \
   --tags "$resource_tags"                                                                                  \
   --storage-sku Standard_LRS                                                                               \
   --os-disk-name "$vm_name""_osdisk"                                                                       \
   --image UbuntuLTS                                                                                        \
   --size "$vm_size"                                                                                        \
   --nics "$nic_name"                                                                                       \
   --authentication-type ssh                                                                                \
   --ssh-key-value "$(< ~/.ssh/"$vm_name"_id_rsa.pub)"
   #--vnet-name "$vm_name" \
   #--subnet "$vm_name" \
   #--authentication-type password \
   #--admin-username "?" \
   #--admin-password "?"

# Install ssh keys to remote machine
ssh -i ~/.ssh/$vm_name"_id_rsa" -o "StrictHostKeyChecking no" $user_name@$vm_dns_name "echo 'SSH key transferred.'"

# Print out the IP address of the VM just created
vm_public_ip=$(az vm list-ip-addresses -n $vm_name --query "[].{ip: virtualMachine.network.publicIpAddresses | [0].ipAddress}" --output tsv)
echo "IP address of the VM: $vm_public_ip"
echo "DNS name of the VM: $vm_dns_name"

echo "----------------------------------------------END---------------------------------------------------"
