#!/bin/bash
for i in `seq 300000 25000 1000000`;
do
    echo $i >> times.txt;
    /usr/bin/time -f "%U %S" sh -c "echo $i | guile tree.scm > /dev/null" 2&>> times.txt;
    echo $i;
done

