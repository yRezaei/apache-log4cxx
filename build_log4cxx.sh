#!/bin/bash
_script="$(readlink -f ${BASH_SOURCE[0]})"
root_dir="$(dirname $_script)"
mkdir tmp

mkdir $root_dir/libxml2
cd tmp
git clone https://github.com/GNOME/libxml2.git
cd libxml2
./autogen.sh
./configure -prefix=$root_dir/libxml2
make -j10
make install
cd $root_dir/tmp && rm -rf libxml2


mkdir $root_dir/apr
wget http://archive.apache.org/dist/apr/apr-1.7.0.tar.gz
tar -xzf apr-1.7.0.tar.gz
rm apr-1.7.0.tar.gz 
mv apr-1.7.0 apr
cd apr
#./buildconf
./configure -prefix=$root_dir/apr --with-libxml2=$root_dir/libxml2
make -j10
make install

cd $root_dir/tmp
mkdir $root_dir/apr-util
#wget -O apr-util.tar.gz https://github.com/apache/apr-util/archive/1.6.1.tar.gz
wget -O apr-util.tar.gz wget http://archive.apache.org/dist/apr/apr-util-1.6.1.tar.gz
tar -xzf apr-util.tar.gz
rm apr-util.tar.gz 
mv apr-util-1.6.1 apr-util
cd apr-util
#./buildconf
./configure -prefix=$root_dir/apr-util --with-apr=$root_dir/apr/bin/apr-1-config --with-expat=$root_dir
make -j10
make install

cd $root_dir/tmp && rm -rf apr apr-util

mkdir $root_dir/log4cxx
git clone https://github.com/apache/logging-log4cxx $root_dir/tmp/log4cxx
cd log4cxx
./autogen.sh
./configure -prefix=$root_dir/log4cxx --with-apr=$root_dir/apr/bin/apr-1-config --with-apr-util=$root_dir/apr-util
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$root_dir/expat/lib
make -j10
make install

cd $root_dir && rm -rf tmp
