#!/bin/sh
#file to test code. 


set -e
cmake $(dirname $0) -B build > /dev/null
cmake --build build > /dev/null
exec ./build/bittorrent "$@"
