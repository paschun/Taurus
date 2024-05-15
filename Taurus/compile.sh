#!/usr/local/bin/bash
root="."
rm -rv *.o $root/out

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
expanded_src_files="${srcfiles[@]/*/$srcdir&'.cpp'}"
expanded_o_files="${srcfiles[@]/*/'./'&'.o'}"

echo compiling...
g++ -O3 -I "$root/include/" -fopenmp -c $expanded_src_files ./test.cpp  && \
g++ -O3 -I "$root/include/" -fopenmp $expanded_o_files ./test.o -o ./testc

rm -v *.o
mkdir $root/out/
mv testc $root/out/
