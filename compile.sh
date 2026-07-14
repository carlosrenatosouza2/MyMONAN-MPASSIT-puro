#! /bin/bash -x
#
# Author: CRS

target=${1:-"jaci"}
compiler=${2:-"gnu"}
debug=${3:-"false"}

# Load modules

. setenv_jaci_gnu_compile_ESMFjaci.bash


export CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=../ \
  -DEMC_EXEC_DIR=ON \
  -DBUILD_TESTING=OFF \
  -DCMAKE_C_COMPILER=cc \
  -DCMAKE_CXX_COMPILER=CC \
  -DCMAKE_Fortran_COMPILER=ftn \
  -DCMAKE_BUILD_TYPE=Release \
  -DNETCDF_C_LIBRARY=${NETCDF_DIR}/lib/libnetcdf.so \
  -DNETCDF_Fortran_LIBRARY=${NETCDF_DIR}/lib/libnetcdff.so \
  -DNETCDF_C_INCLUDE_DIR=${NETCDF_DIR}/include \
  -DNETCDF_Fortran_INCLUDE_DIR=${NETCDF_DIR}/include"

if [[ "${debug}" == "true" ]]; then
    CMAKE_FLAGS="${CMAKE_FLAGS} -DCMAKE_BUILD_TYPE=Debug"
else
    CMAKE_FLAGS="${CMAKE_FLAGS} -DCMAKE_BUILD_TYPE=Release"
fi

rm -fr ./build
mkdir ./build && cd ./build || exit 0

# Build
cmake .. ${CMAKE_FLAGS}
make -j 8 VERBOSE=1
make install
