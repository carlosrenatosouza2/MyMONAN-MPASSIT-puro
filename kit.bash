#!/bin/bash

DIRHOME=$(pwd)

nedit \
${DIRHOME}/input_data.F90 \
${DIRHOME}/interp.F90 \
${DIRHOME}/write_data.F90 \
${DIRHOME}/run/mpassit_submit.bash \
${DIRHOME}/run/varlist_2d \
${DIRHOME}/run/varlist_3d \
${DIRHOME}/run/namelist.input \
${DIRHOME}/run/mpassit.out \
${DIRHOME}/run/mpassit.err \
${DIRHOME}/kit.bash &
