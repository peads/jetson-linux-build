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

# Install the kernel source for L4T
source scripts/jetson_variables

#Print Jetson version
echo "$JETSON_MACHINE"
#Print Jetpack version
echo "Jetpack $JETSON_JETPACK [L4T $JETSON_L4T]"
SOURCE_TARGET="/usr/src/"
KERNEL_RELEASE=$(./scripts/findKernelRelease.sh)

LAST="${SOURCE_TARGET: -1}"
if [ $LAST != '/' ] ; then
   SOURCE_TARGET="$SOURCE_TARGET""/"
fi

echo "Kernel Release: $KERNEL_RELEASE"
echo "Placing kernel source into $SOURCE_TARGET"

# Check to see if source tree is already installed
PROPOSED_SRC_PATH="$SOURCE_TARGET""kernel/kernel-"$KERNEL_RELEASE
if [ -d "$PROPOSED_SRC_PATH" ]; then
  tput setaf 1
  echo "==== Kernel source appears to already be installed! =============== "
  tput sgr0
  echo "The kernel source appears to already be installed at: "
  echo "   ""$PROPOSED_SRC_PATH"
  echo "If you want to reinstall the source files, first remove the directories: "
  echo "  ""$SOURCE_TARGET""kernel"
  echo "  ""$SOURCE_TARGET""hardware"
  echo "then rerun this script"
  exit 1
fi

export SOURCE_TARGET
export KERNEL_RELEASE

# -E preserves environment variables
sudo -E ./scripts/getKernelSources.sh


