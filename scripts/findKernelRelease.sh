#!/bin/bash
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
# TODO make this a little bit smarter. e.g., looking for the names via /usr/src/kernel-x.x
echo $(uname -a | grep -lq tegra - && uname -r | cut -d. -f1-2 || echo "4.9")
