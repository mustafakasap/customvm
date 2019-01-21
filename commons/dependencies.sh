echo "------------------------------------------------------------------------------------------------------"
echo " dependencies.sh"
echo "------------------------------------------------------------------------------------------------------"

: '
Desc: 	Update & Upgrade the system
		http://manpages.ubuntu.com/manpages/xenial/en/man8/apt-get.8.html

	   update
           update is used to resynchronize the package index files from their
           sources. The indexes of available packages are fetched from the
           location(s) specified in /etc/apt/sources.list. For example, when
           using a Debian archive, this command retrieves and scans the
           Packages.gz files, so that information about new and updated
           packages is available. An update should always be performed before
           an upgrade or dist-upgrade. Please be aware that the overall
           progress meter will be incorrect as the size of the package files
           cannot be known in advance.

       upgrade
           upgrade is used to install the newest versions of all packages
           currently installed on the system from the sources enumerated in
           /etc/apt/sources.list. Packages currently installed with new
           versions available are retrieved and upgraded; under no
           circumstances are currently installed packages removed, or packages
           not already installed retrieved and installed. New versions of
           currently installed packages that cannot be upgraded without
           changing the install status of another package will be left at
           their current version. An update must be performed first so that
           apt-get knows that new versions of packages are available.

       dist-upgrade
           dist-upgrade in addition to performing the function of upgrade,
           also intelligently handles changing dependencies with new versions
           of packages; apt-get has a "smart" conflict resolution system, and
           it will attempt to upgrade the most important packages at the
           expense of less important ones if necessary. The dist-upgrade
           command may therefore remove some packages. The
           /etc/apt/sources.list file contains a list of locations from which
           to retrieve desired package files. See also apt_preferences(5) for
           a mechanism for overriding the general settings for individual
           packages.
Prereq:	-

Ref:
'

# Update whole system
sudo apt-get -y update        # Fetches the list of available updates
sudo apt-get -y upgrade       # Strictly upgrades the current packages


# Dont care about pip version, use two different pip for python versions...
sudo apt remove python-pip
sudo apt remove python3-pip
sudo apt-get -y install python-pip
sudo apt-get -y install python3-pip


# TensorFlow pip package dependencies
pip install -U --user six numpy wheel mock
pip install -U --user keras_applications==1.0.6 --no-deps
pip install -U --user keras_preprocessing==1.0.5 --no-deps

pip3 install -U --user six numpy wheel mock
pip3 install -U --user keras_applications==1.0.6 --no-deps
pip3 install -U --user keras_preprocessing==1.0.5 --no-deps


# required by Tensorflow
sudo pip install enum34
sudo pip3 install enum34

# intel_mkl
sudo apt-get -y install cmake

echo "----------------------------------------------END dependencies.sh ------------------------------------"
