. ${disk_mnt_point}/tmp/source_urls.sh
cd ${disk_mnt_point}/tmp/

echo "------------------------------------------------------------------------------------------------------"
echo " X2Go"
echo "------------------------------------------------------------------------------------------------------"
sudo apt-get -y install software-properties-common
sudo add-apt-repository ppa:x2go/stable
sudo apt-get -y update
sudo apt-get -y install x2goserver x2goserver-xsession xfce4



echo "------------------------------------------------------------------------------------------------------"
echo " Chrome Browser"
echo "------------------------------------------------------------------------------------------------------"
cd ${disk_mnt_point}/tmp/
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get -y update
sudo apt-get -y install google-chrome-stable



echo "------------------------------------------------------------------------------------------------------"
echo " Sublime"
echo "------------------------------------------------------------------------------------------------------"
cd ${disk_mnt_point}/tmp/
wget -q -O - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get -y install sublime-text



echo "------------------------------------------------------------------------------------------------------"
echo " Storage Explorer"
echo "------------------------------------------------------------------------------------------------------"
cd ${disk_mnt_point}/tmp/
wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo apt-get -y install apt-transport-https
sudo apt-get update
sudo apt-get -y install aspnetcore-runtime-2.2


wget -nv ${STRGEXPL_URL} -O ${disk_mnt_point}/tmp/${STRGEXPL}
cd ~
mkdir storageexplorer
tar -xvf ${disk_mnt_point}/tmp/${STRGEXPL} -C ~/storageexplorer



echo "------------------------------------------------------------------------------------------------------"
echo " GPICView Image viewer"
echo "------------------------------------------------------------------------------------------------------"
sudo apt-get install gpicview
