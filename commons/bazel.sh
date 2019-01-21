echo "------------------------------------------------------------------------------------------------------"
echo " bazel.sh"
echo "------------------------------------------------------------------------------------------------------"

# Source: https://docs.bazel.build/versions/master/install-ubuntu.html
# Check for latest version in case.

. ${disk_mnt_point}/tmp/source_urls.sh

sudo apt-get install -y pkg-config zip g++ zlib1g-dev unzip

wget -nv ${BAZEL_URL} -O ${disk_mnt_point}/tmp/${BAZEL} && sudo dpkg -i ${disk_mnt_point}/tmp/${BAZEL}

sudo apt-get -y update
sudo apt-get -y install bazel


# Post-installation Actions
cd ${HOME}
echo "export PATH=$HOME/bin:${PATH}" | sudo tee --append /etc/profile.d/bazel.sh

echo "----------------------------------------------END bazel.sh--------------------------------------------"
