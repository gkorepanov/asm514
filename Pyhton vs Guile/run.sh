#!/bin/bash
for i in `seq 1 5000`;
do
    echo $i >> times.txt;
    (time echo $i | python tree.py > /dev/null) 2>&1 | head -n2 | tail -n1 | rev | head -c8 | rev >> times.txt;
echo $i;
done

