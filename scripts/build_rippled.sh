#/bin/bash

#Install Dependencies
apt-get -y install git pkg-config protobuf-compiler libprotobuf-dev libssl-dev wget

#Download CMake 
wget https://github.com/Kitware/CMake/releases/download/v3.13.3/cmake-3.13.3-Linux-x86_64.sh

#Install Cmake
sh cmake-3.13.3-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir

#Download Boost build source
wget https://dl.bintray.com/boostorg/release/1.71.0/source/boost_1_71_0.tar.gz

#Extract and build boost
tar xvzf boost_1_71_0.tar.gz
cd boost_1_71_0
./bootstrap.sh
./b2 -j 4

#Set boost_root as ENV variable 
export BOOST_ROOT=/tmp/boost_1_71_0


#Update profile
source ~/.profile

cd ../

#Download Rippled source Code
git clone https://github.com/ripple/rippled.git
cd rippled
git checkout master

#Generate my_build directory and build rippled
mkdir my_build
cd my_build
cmake ..
cmake --build .

#Run rippled UnitTests - If no errors, Succesfully Installed
./rippled -u
