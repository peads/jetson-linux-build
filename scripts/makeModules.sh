#!/bin/bash
###########################
# ORIGINAL LICENSE NOTICE #
###########################
# Make kernel modules for NVIDIA Jetson Developer Kit
# Copyright (c) 2016-21 Jetsonhacks 
# MIT License
######################
# NEW LICENSE NOTICE #
######################
# This file is part of the jetson-linux-build distribution
# (https://github.com/peads/jetson-linux-build).
# Copyright (c) 2024 Patrick Eads.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
echo "Source Target: "$SOURCE_TARGET

cd $SOURCE_TARGET"kernel/kernel-"$KERNEL_RELEASE

NUM_CPU=$(nproc)
# TODO see TODO in `./makeKernel.sh`
NUM_JOBS=24
# Make the kernel Image 
# TODO see TODO in `./makeKernel.sh`
time make -j${NUM_JOBS} -l$(($NUM_CPU - 1)) modules CC="distcc aarch64-unknown-linux-gnu-gcc"
if [ $? -eq 0 ] ; then
  echo "Modules make successful"
else
  # Try to make again; Sometimes there are issues with the build
  # because of lack of resources or concurrency issues
  echo "Make did not build " >&2
  echo "Retrying ... "
  # Single thread this time
  make modules
  if [ $? -eq 0 ] ; then
    echo "Module make successful"
  else
    # Try to make again
    echo "Make did not successfully build modules" >&2
    echo "Please fix issues and retry build"
    exit 1
  fi
fi

make modules_install


