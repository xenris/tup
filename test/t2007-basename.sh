#! /bin/sh -e
# tup - A file-based build system
#
# Copyright (C) 2009-2021  Mike Shal <marfey@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

# Test the basename flags (%B and %b)

. ./tup.sh
cat > Tupfile << HERE
: superlongtest/ok |> cp %f %o |> %B.o
: foreach subdir/*.txt |> cp %f %o |> %b
: foreach subdir/*.c |> gcc -c %f -o %o |> %B.o
HERE
mkdir subdir
mkdir superlongtest
touch subdir/foo.c subdir/readme.txt Tupfile superlongtest/ok
parse
tup_object_exist . foo.o readme.txt
tup_object_exist . "cp subdir/readme.txt readme.txt"
tup_object_exist . "gcc -c subdir/foo.c -o foo.o"
tup_object_exist . "cp superlongtest/ok ok.o"

eotup
