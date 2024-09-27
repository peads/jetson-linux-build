#!/bin/bash
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
echo "This removes all occurences of escalating compiler warnings to errors. USE AT YOUR OWN RISK"
read -r -p "Are you sure? [y/N] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
    grep -rl "\-Werror-[A-Za-z0-9\-]\+" . | sudo xargs sed -i 's/-Werror-[A-Za-z0-9-]\+//g';
    grep -rl "\-Werror=[A-Za-z0-9-]\+" . | sudo xargs sed -i 's/-Werror=[A-Za-z0-9-]\+//g';
    grep -rl "\-Werror\s" . | sudo xargs sed -i 's/-Werror\s//g';
    grep -rl "\-Werror$" . | sudo xargs sed -i 's/-Werror$//g';
else
    exit 1;
fi

