sudo yum install centos-release-scl
sudo yum install devtoolset-6-gcc*
scl enable devtoolset-6 bash
which gcc
gcc --version
