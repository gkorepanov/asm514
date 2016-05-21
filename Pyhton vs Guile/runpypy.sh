#!/bin/bash
for i in `seq 1 1000 1000000`;
do
    echo $i >> times.txt;
    /usr/bin/time -f "%U %S" sh -c "echo $i | pypy tree.py > /dev/null" 2&>> times.txt;
    echo $i;
done

