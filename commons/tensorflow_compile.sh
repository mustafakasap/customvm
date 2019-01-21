echo "------------------------------------------------------------------------------------------------------"
echo " tensorflow_compile.sh"
echo "------------------------------------------------------------------------------------------------------"

echo "------------------------------------------------------------------------------------------------------"
echo "      Compiling Tensorflow for python 2 whell"
echo "------------------------------------------------------------------------------------------------------"

cd ${disk_mnt_point}/tmp/

git clone  --branch master --single-branch https://github.com/tensorflow/tensorflow.git
cd tensorflow

cp ${disk_mnt_point}/tmp/tf_bazel_config.p2 ${disk_mnt_point}/tmp/tensorflow/.tf_configure.bazelrc
echo -e "export PYTHON_BIN_PATH=\"/usr/bin/python\"" > ./tools/python_bin_path.sh
bazel build --config=opt --config=cuda --config=mkl  --verbose_failures //tensorflow/tools/pip_package:build_pip_package
./bazel-bin/tensorflow/tools/pip_package/build_pip_package ${disk_mnt_point}/tmp/




echo "------------------------------------------------------------------------------------------------------"
echo "      Compiling Tensorflow for python 3 whell"
echo "------------------------------------------------------------------------------------------------------"

cd ${disk_mnt_point}/tmp/
cd tensorflow

cp ${disk_mnt_point}/tmp/tf_bazel_config.p3 ${disk_mnt_point}/tmp/tensorflow/.tf_configure.bazelrc
echo -e "export PYTHON_BIN_PATH=\"/usr/bin/python3.5\"" > ./tools/python_bin_path.sh
bazel build --config=opt --config=cuda --config=mkl  --verbose_failures //tensorflow/tools/pip_package:build_pip_package
./bazel-bin/tensorflow/tools/pip_package/build_pip_package ${disk_mnt_point}/tmp/


pip install ${disk_mnt_point}/tmp/tensorflow*cp27*.whl
pip3 install ${disk_mnt_point}/tmp/tensorflow*cp35*.whl

echo "----------------------------------------------END tensorflow_compile.sh ------------------------------"
