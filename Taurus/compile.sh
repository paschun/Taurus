#!/usr/local/bin/bash

#### config

wasm=true
root="."

#### end config

set -u # no references to undefined vars
set -o pipefail
IFS=$'\n\t'
if $wasm; then
  cc="em++"
else
  cc="g++"
fi

rm -rv $root/out ./*.{o,tmp,wasm,js,mjs,html,d.ts}

srcdir="$root/src/"
srcfiles=(
    solver
    RepulsiveForce
    Multilevel
    layout
    Quad
    PivotMDS
    shuffle
    # metric
)
# run.sh only had first 4 srcfiles

# https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion
expanded_src_files=${srcfiles[*]/*/$srcdir&'.cpp'}

echo compiling...
mkdir $root/out/

if $wasm; then
  set -x
  # remove -g to minify
  $cc -O3 -I $root/include/ -fopenmp $expanded_src_files ./test.cpp --emit-tsd types.d.ts -g -o ./testc.mjs
  mv -v ./*.mjs ./*.wasm ./*.d.ts $root/out/
else
  set -x
  $cc -O3 -I $root/include/ -fopenmp $expanded_src_files ./test.cpp -o ./testc
  mv -v testc $root/out/
fi
