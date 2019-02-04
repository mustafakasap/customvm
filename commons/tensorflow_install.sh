echo "------------------------------------------------------------------------------------------------------"
echo " BEGIN: tensorflow_install.sh"
echo "------------------------------------------------------------------------------------------------------"

. ${disk_mnt_point}/tmp/source_urls.sh

# Download source compiled packages
wget -nv ${TFV113RCP2_URL} -O ${disk_mnt_point}/tmp/${TFV113RCP2}
wget -nv ${TFV113RCP3_URL} -O ${disk_mnt_point}/tmp/${TFV113RCP3}

pip install ${disk_mnt_point}/tmp/${TFV113RCP2}
pip3 install ${disk_mnt_point}/tmp/${TFV113RCP3}
echo " END: tensorflow_install.sh --------------------------------------------------------------------------"
