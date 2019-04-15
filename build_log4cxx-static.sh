#!/bin/bash
_script="$(readlink -f ${BASH_SOURCE[0]})"
root_dir="$(dirname $_script)"
mkdir tmp
cd tmp

wget http://archive.apache.org/dist/apr/apr-1.7.0.tar.gz
tar -xzf apr-1.7.0.tar.gz
rm apr-1.7.0.tar.gz 
mv apr-1.7.0 apr

wget -O apr-util.tar.gz http://archive.apache.org/dist/apr/apr-util-1.5.4.tar.gz
tar -xzf apr-util.tar.gz
rm apr-util.tar.gz 
mv apr-util-1.5.4 apr-util

mkdir $root_dir/expat
cd $root_dir/tmp/apr-util/xml/expat/
./configure CPPFLAGS="-fPIC -Bstatic" --prefix=$root_dir/expat --with-pic --enable-static
make -j8
make install

mkdir $root_dir/apr
cd $root_dir/tmp/apr
./configure CPPFLAGS="-fPIC -Bstatic" --prefix=$root_dir/apr --with-pic --enable-static
make -j8
make install

mkdir $root_dir/apr-util
cd $root_dir/tmp/apr-util/
./configure CPPFLAGS="-fPIC -Bstatic" --prefix=$root_dir/apr-util --with-apr=../apr
make -j8
make install

mkdir $root_dir/log4cxx
cd $root_dir/tmp/
git clone https://github.com/apache/logging-log4cxx log4cxx
cd log4cxx
./autogen.sh
./configure CPPFLAGS="-fPIC -Bstatic" --prefix=$root_dir/log4cxx --with-pic --enable-static \
    --with-apr=../apr --with-apr-util=../apr-util
make -j8
make install

cd $root_dir && rm -rf tmp
