#!/bin/bash

# * Name: earthwall.sh
# * Description: Downloads random image from earthview.withgoogle.com and sets as wallpaper on OSX
# * Author: Rafael Leyva
# * Date: 09/07/2015 22:24:11 WEST
# * License: This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# * Copyright (c) 2015, Rafael Leyva	

# Test if OSX
if [ "$(uname -s)" != "Linux" ] ; then
	echo "This script only works on Linux"
	exit 1
fi

mkdir -p $HOME/Pictures/earthwall

# Get page index
wget -q http://earthview.withgoogle.com -O $HOME/Pictures/earthwall/.index.html 2> /dev/null
if [ $? -ne 0 ]; then
	echo "Failed to get index from earthview.withgoogle.com"
	exit 1
fi

# Set image url, name and location
image_url=`grep  -m 1 -o 'https://www.gstatic.com/prettyearth/assets/full/[0-9]\{0,6\}.jpg' $HOME/Pictures/earthwall/.index.html | head -n1`
image_name=`echo $image_url | grep '[0-9]\{0,6\}.jpg' -m 1 -o`

# TODO: The html has changed, I cannot obtain image location easly
#cat $HOME/Pictures/earthwall/.index.html | grep title=\"View | grep -o 'View.*in' | sed 's/View //g' | sed 's/ in//g' > $HOME/Pictures/earthwall/.image_location
#image_location=`cat $HOME/Pictures/earthwall/.image_location | sed 's/, /,/g' | sed 's/ /_/g'`

# Get image
wget -q $image_url -O $HOME/Pictures/earthwall/$image_name 2> /dev/null
if [ $? -ne 0 ]; then
	echo "Failed to get image from www.gstatic.com"
	exit 1
fi

feh --bg-scale $HOME/Pictures/earthwall/$image_name 2> /dev/null

echo "Wallpaper changed to $image_name"
exit 0
