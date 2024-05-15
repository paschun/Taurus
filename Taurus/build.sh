#!/usr/local/bin/bash
rm -rv out
g++ test.cpp -I include/ -L. lib/libtaurus.a -o out/testc
