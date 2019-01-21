echo "------------------------------------------------------------------------------------------------------"
echo " intel_mkl_dnn.sh"
echo "------------------------------------------------------------------------------------------------------"

cd ${disk_mnt_point}/tmp/

git clone https://github.com/intel/mkl-dnn.git

cd mkl-dnn 
cd scripts 
./prepare_mkl.sh
cd ..

mkdir -p build && cd build && cmake $CMAKE_OPTIONS ..

make

sudo make install

echo "----------------------------------------------END intel_mkl_dnn.sh -----------------------------------"
