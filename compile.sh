#! /bin/bash -x
#
# Author: CRS

target=${1:-"jaci"}
compiler=${2:-"gnu"}
debug=${3:-"false"}

# Load modules
module purge
module load PrgEnv-gnu
module load craype-x86-turin
module load cray-hdf5-parallel/1.14.3.3
module load cray-netcdf-hdf5parallel/4.9.0.15
module load cray-parallel-netcdf/1.12.3.15
module load xpmem/0.2.119-1.3_gef379be13330
module load cray-pals
module load METIS/5.1.0
module list

# NetCDF paralelo - NETCDF_DIR eh definido pelo modulo cray-netcdf-hdf5parallel
export NETCDF=${NETCDF_DIR}

# Compiladores Cray
export CMAKE_C_COMPILER=cc
export CMAKE_Fortran_COMPILER=ftn

# ESMF compilado com NetCDF paralelo
export ESMF_DIR=/lustre/projetos/monan_adm/carlos.souza/ESMF/esmf-8.9.1
export ESMF_INCDIR=${ESMF_DIR}/src/include
export ESMF_LIBDIR=${ESMF_DIR}/lib/libO/Linux.gfortran.64.mpich2.default
export ESMF_MODDIR=${ESMF_DIR}/mod/modO/Linux.gfortran.64.mpich2.default
export ESMFMKFILE=${ESMF_DIR}/lib/libO/Linux.gfortran.64.mpich2.default/esmf.mk
export LIBRARY_PATH=${LIBRARY_PATH}:${ESMF_DIR}/lib/libO/Linux.gfortran.64.mpich2.default
export LD_LIBRARY_PATH=${NETCDF_DIR}/lib:${ESMF_DIR}/lib/libO/Linux.gfortran.64.mpich2.default:${LD_LIBRARY_PATH}
export PATH=${PATH}:${ESMF_DIR}/apps/appsO/Linux.gfortran.64.mpich2.default

export ESMF_FFLAGS="-I${ESMF_MODDIR} -I${ESMF_INCDIR}"
export ESMF_LDFLAGS="-L${ESMF_LIBDIR} -lesmf"
export ESMF_COMPILER="gfortran"
export ESMF_F90COMPILER=ftn
export ESMF_CXXCOMPILER=CC
export ESMF_CCCOMPILER=cc
export ESMF_F90LINKER=ftn

# Confirma que NETCDF_DIR aponta para o paralelo
echo "NETCDF_DIR = ${NETCDF_DIR}"
nc-config --has-parallel4

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
