#!/bin/sh

echo "------------------------------------------------------------------------------------------------------"
echo " opencv_compile.sh"
echo "------------------------------------------------------------------------------------------------------"

. ${disk_mnt_point}/tmp/source_urls.sh

# Developer tools
sudo apt-get install build-essential cmake unzip pkg-config

# Image and video I/O libraries
sudo apt-get -y install libjpeg-dev libpng-dev libtiff-dev
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get -y install libxvidcore-dev libx264-dev


# Mathematical optimization libs for OpenCV
sudo apt-get -y install libatlas-base-dev gfortran

# Python 2 & 3 development headers
sudo apt-get -y install python3-dev python-dev

# Download OpenCV 4
wget -nv ${OPENCV_URL} -O ${disk_mnt_point}/tmp/opencv.zip
wget -nv ${OPENCVCONT_URL} -O ${disk_mnt_point}/tmp/opencv_contrib.zip

cd ${disk_mnt_point}/tmp/
unzip opencv.zip
unzip opencv_contrib.zip

rm -rf opencv.zip
rm -rf opencv_contrib.zip

mv opencv-4.0.0 opencv
mv opencv_contrib-4.0.0 opencv_contrib

# Install NumPy
pip install numpy
pip3 install numpy


# Installing video I/O components.
sudo apt install -y                                                           \
  libavcodec-dev                                                              \
  libavformat-dev                                                             \
  libdc1394-22-dev                                                            \
  libopencore-amrnb-dev                                                       \
  libopencore-amrwb-dev                                                       \
  libswscale-dev                                                              \
  libtheora-dev                                                               \
  libv4l-dev                                                                  \
  libvorbis-dev                                                               \
  libx264-dev                                                                 \
  libxine2                                                                    \
  libxine2-dev                                                                \
  libxvidcore-dev                                                             \
  yasm

# Installing GUI components.
sudo apt install -y                                                           \
  libharfbuzz-dev                                                             \
  libvtk6-dev                                                                 \
  libgtk-3-dev                                                                \
  python-vtk6                                                                 \
  qt5-default

# Installing Streaming Components.
sudo apt install -y                                                           \
  gstreamer1.0-doc                                                            \
  gstreamer1.0-libav                                                          \
  gstreamer1.0-plugins-bad                                                    \
  gstreamer1.0-plugins-base                                                   \
  gstreamer1.0-plugins-good                                                   \
  gstreamer1.0-plugins-ugly                                                   \
  gstreamer1.0-tools                                                          \
  libgstreamer1.0-0                                                           \
  libgstreamer1.0-dev                                                         \
  libgstreamer-plugins-bad1.0-dev                                             \
  libgstreamer-plugins-base1.0-dev                                            \
  libgstreamer-plugins-good1.0-dev



# CMake and compile OpenCV 4
cd ${disk_mnt_point}/tmp/opencv
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D INSTALL_C_EXAMPLES=OFF \
	-D OPENCV_ENABLE_NONFREE=ON \
	-D OPENCV_EXTRA_MODULES_PATH=${disk_mnt_point}/tmp/opencv_contrib/modules \
	-D PYTHON_EXECUTABLE=/usr/bin/python3 \
	-D BUILD_EXAMPLES=ON ..

# Compile OpenCV 4
make -j$(($(nproc)+1))

# Install OpenCV 4
sudo make install
sudo ldconfig

cd /usr/local/python/cv2/python-3.5
sudo mv cv2.cpython-35m-x86_64-linux-gnu.so cv2.so

cd /usr/lib/python3.5/dist-packages
sudo ln -s /usr/local/python/cv2/python-3.5/cv2.so cv2.so

echo "----------------------------------------------END opencv_compile.sh-----------------------------------"
