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
SOURCE_TARGET="/usr/src"
#KERNEL_RELEASE=$(uname -a | grep -lq tegra - && uname -r | cut -d. -f1-2 || echo "4.9")
KERNEL_RELEASE=$(./scripts/findKernelRelease.sh)

function usage
{
    echo "usage: ./makeKernel.sh [[-d directory ]  | [-h]]"
    echo "-d | --directory Directory path to parent of kernel"
    echo "-h | --help  This message"
}

# Iterate through command line inputs
while [ "$1" != "" ]; do
    case $1 in
        -d | --directory )      shift
				SOURCE_TARGET=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

LAST="${SOURCE_TARGET: -1}"
if [ $LAST != '/' ] ; then
   SOURCE_TARGET="$SOURCE_TARGET""/"
fi

# Check to see if source tree is already installed
PROPOSED_SRC_PATH="$SOURCE_TARGET""kernel/kernel-"$KERNEL_RELEASE
echo "Proposed source path: ""$PROPOSED_SRC_PATH"
if [ ! -d "$PROPOSED_SRC_PATH" ]; then
  tput setaf 1
  echo "==== Cannot find kernel source! =============== "
  tput sgr0
  echo "The kernel source does not appear to be installed at: "
  echo "   ""$PROPOSED_SRC_PATH"
  echo "Unable to start making kernel."
  exit 1
fi

export SOURCE_TARGET
export KERNEL_RELEASE

# E Option carries over environment variables
sudo -E ./scripts/makeKernel.sh
