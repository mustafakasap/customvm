#!/bin/sh

# Define several global variables to be used for setting the DSVM properties
echo "------------------------------------------------------------------------------------------------------"
echo " Setting Azure specific script parameters"
echo "------------------------------------------------------------------------------------------------------"

# If you have more than one Azure subscription, under which subscription are these resources will be created?
# You may get your subscription ID (https://account.azure.com/subscriptions)
# if not using azure, you can omit this parameter.
# azure_subscription_id='12345-6789-abcd-xyzw-9876b651234a'
azure_subscription_id='HERE WRITE DOWN YOUR OWN AZURE SUBSCRIPTION KEY'


# Resource names (i.e. VM, storage) constructed from resource_name and suffix parameters
# MUST BE lowercase with unix file name standards (no special characters, dash, underscore etc.)
# i.e. VM Name = resource_name+suffix
# resource_name="mydsvm"
resource_name="GIVE ANY NAME TO YOUR VM"

# List of possible resource locations. Used to set resource_location parameter
# to get the updated list use the following commands:
#  az login
#  az account list-locations
#
: '
        DisplayName     	Name
        ----------------	------------------
        East Asia       	eastasia
        Southeast Asia  	southeastasia
        Central US      	centralus
        East US         	eastus
        East US 2       	eastus2
        West US         	westus
        North Central US	northcentralus
        South Central US	southcentralus
        North Europe    	northeurope
        West Europe     	westeurope
        Japan West      	japanwest
        Japan East      	japaneast
        Brazil South    	brazilsouth
        Australia East  	australiaeast
        Australia Southeast	australiasoutheast
        South India     	southindia
        Central India   	centralindia
        West India      	westindia
        Canada Central  	canadacentral
        Canada East     	canadaeast
        UK South        	uksouth
        UK West         	ukwest
        West Central US 	westcentralus
        West US 2       	westus2
        Korea Central   	koreacentral
        Korea South     	koreasouth
        France Central  	francecentral
        France South    	francesouth
        Australia Central	australiacentral
        Australia Central 2	australiacentral2
'

# Datacenter region you want to create your resources
# select a location from above table's name column
resource_location='eastus'

# Virtual Machine Name
vm_name=$resource_name$suffix

# Static DNS name of the VM.
vm_dns_name="$vm_name"".""$resource_location"".cloudapp.azure.com"


# VM SKUs, sizes, types. Check source for any updates on the list more details: https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes
# Used to set vm_size parameter
: '
        B-Series        DS-v3-Series        D-v3-Series             DS-v2-Series        D-v2-Series         D2-v2-Series        DS2-v2-Series       DS-Series       D-Series        A-v2-Series         A-Compute-Series    A-Series            A-Basic-Series  FS-v2-Series        FS-Series       F-v2-Series         F-Series            ES-v3-Series        E2-v3-Series        M-Series            GS-Series       G-Series        LS-Series       NC-Series       NC-v2-Series        NC-v3-Series        ND-Series       NV-Series       H-Series
        Standard_B1s    Standard_D2s_v3     Standard_D2_v3          Standard_DS1_v2     Standard_D1_v2      Standard_D11_v2     Standard_DS11_v2    Standard_DS1    Standard_D1     Standard_A1_v2      Standard_A8         Standard_A0         A0\Basic_A0     Standard_F2s_v2     Standard_F1s    Standard_F2_v2      Standard_F1         Standard_E2s_v3     Standard_E2_v3      Standard_M64s       Standard_GS1    Standard_G1     Standard_L4s    Standard_NC6    Standard_NC6_v2     Standard_NC6s_v3    Standard_ND6    Standard_NV6    Standard_H8
        Standard_B1ms   Standard_D4s_v3     Standard_D4_v3          Standard_DS2_v2     Standard_D2_v2      Standard_D12_v2     Standard_DS12_v2    Standard_DS2    Standard_D2     Standard_A2_v2      Standard_A9         Standard_A1         A1\Basic_A1     Standard_F4s_v2     Standard_F2s    Standard_F4_v2      Standard_F2         Standard_E4s_v3     Standard_E4_v3      Standard_M64ms      Standard_GS2    Standard_G2     Standard_L8s    Standard_NC12   Standard_NC12_v2    Standard_NC12s_v3   Standard_ND12   Standard_NV12   Standard_H16
        Standard_B2s    Standard_D8s_v3     Standard_D8_v3          Standard_DS3_v2     Standard_D3_v2      Standard_D13_v2     Standard_DS13_v2    Standard_DS3    Standard_D3     Standard_A4_v2      Standard_A10        Standard_A2         A2\Basic_A2     Standard_F8s_v2     Standard_F4s    Standard_F8_v2      Standard_F4         Standard_E8s_v3     Standard_E8_v3      Standard_M128s      Standard_GS3    Standard_G3     Standard_L16s   Standard_NC24   Standard_NC24_v2    Standard_NC24s_v3   Standard_ND24   Standard_NV24   Standard_H8m
        Standard_B2ms   Standard_D16s_v3    Standard_D16_v3         Standard_DS4_v2     Standard_D4_v2      Standard_D14_v2     Standard_DS14_v2    Standard_DS4    Standard_D4     Standard_A8_v2      Standard_A11        Standard_A3         A3\Basic_A3     Standard_F16s_v2    Standard_F8s    Standard_F16_v2     Standard_F8         Standard_E16s_v3    Standard_E16_v3     Standard_M128ms     Standard_GS4    Standard_G4     Standard_L32s   Standard_NC24r  Standard_NC24r_v2   Standard_NC24rs_v3  Standard_ND24r                  Standard_H16m
        Standard_B4ms   Standard_D32s_v3    Standard_D32_v3         Standard_DS5_v2     Standard_D5_v2      Standard_D15_v2     Standard_DS15_v2                                    Standard_A2m_v2     Standard_A4                             A4\Basic_A4     Standard_F32s_v2    Standard_F16s   Standard_F32_v2     Standard_F16        Standard_E32s_v3    Standard_E32_v3     Standard_GS5        Standard_G5                                                                                                                             Standard_H16r
        Standard_B8ms   Standard_D64s_v3    Standard_D64_v3                                                                                                                         Standard_A4m_v2     Standard_A5                                             Standard_F64s_v2                    Standard_F64_v2                         Standard_E64s_v3    Standard_E64_v3                                                                                                                                                                 Standard_H16mr
                                                                                                                                                                                    Standard_A8m_v2     Standard_A6                                             Standard_F72s_v2                    Standard_F72_v2                                             
                                                                                                                                                                                                        Standard_A7
'

# SKU (size) of the VM you want to create (this is the most EXPENSIVE GPU VM type! we use it because it has the lastest GPU model)
# you may select cheaper version so will not consume your cloud credits quickly!
vm_size="Standard_NC6s_v3"


resource_group_name=$resource_name$suffix
resource_tags='Description='$resource_name$suffix
storage_account_name=$resource_name$suffix
public_ip_name=$resource_name$suffix
dns_name=$resource_name$suffix
vnet_name=$resource_name$suffix
vnet_prefix="192.168.0.0/16"
subnet_name="FrontEnd"
subnet_prefix="192.168.1.0/24"
nic_name=$resource_name$suffix
private_ip_address="192.168.1.101"
nsg_name=$resource_name$suffix

# Authentication in the VM will be through SSH (no username enabled...) This username is embedded in the SSH Key 
user_name=$USER

# Additional disk name
disk_name=$resource_name$suffix

# Additional disk size, 1TB
disk_size=1000

# Additional disk device name
disk_dev_name="/dev/sdc"

disk_mnt_point="/extradisk"

# SSH Port
ssh_port=22

# Jupyter Notebook port
jnb_port=8981

echo "----------------------------------------------END---------------------------------------------------"