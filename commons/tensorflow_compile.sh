echo "------------------------------------------------------------------------------------------------------"
echo "  BEGIN: tensorflow_compile.sh"
echo "------------------------------------------------------------------------------------------------------"

echo "------------------------------------------------------------------------------------------------------"
echo " --- Compiling Tensorflow for Python 2 whell"
echo "------------------------------------------------------------------------------------------------------"

cd ${disk_mnt_point}/tmp/

git clone  --branch r1.13 --single-branch https://github.com/tensorflow/tensorflow.git
cd tensorflow
git checkout tags/v1.13.0-rc0


cp ${disk_mnt_point}/tmp/tf_bazel_config.p2 ${disk_mnt_point}/tmp/tensorflow/.tf_configure.bazelrc
echo -e "export PYTHON_BIN_PATH=\"/usr/bin/python\"" > ./tools/python_bin_path.sh
bazel build --config=opt --config=cuda --config=mkl  --verbose_failures //tensorflow/tools/pip_package:build_pip_package
./bazel-bin/tensorflow/tools/pip_package/build_pip_package ${disk_mnt_point}/tmp/




echo "------------------------------------------------------------------------------------------------------"
echo " --- Compiling Tensorflow for Python 3 whell"
echo "------------------------------------------------------------------------------------------------------"

cd ${disk_mnt_point}/tmp/
cd tensorflow

cp ${disk_mnt_point}/tmp/tf_bazel_config.p3 ${disk_mnt_point}/tmp/tensorflow/.tf_configure.bazelrc
echo -e "export PYTHON_BIN_PATH=\"/usr/bin/python3\"" > ./tools/python_bin_path.sh
bazel build --config=opt --config=cuda --config=mkl  --verbose_failures //tensorflow/tools/pip_package:build_pip_package
./bazel-bin/tensorflow/tools/pip_package/build_pip_package ${disk_mnt_point}/tmp/


pip install ${disk_mnt_point}/tmp/tensorflow*cp2*.whl
pip3 install ${disk_mnt_point}/tmp/tensorflow*cp3*.whl

echo " END: tensorflow_compile.sh --------------------------------------------------------------------------"
