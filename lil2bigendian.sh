# Usage: Pipe in a string of hexadecimals in lil endian to output ASCII

#!/bin/bash

# check stdin
if [ -t 0 ]; then exit; fi

v=`cat /dev/stdin`
i=${#v}

# iterates and reverse string
while [ $i -gt 0 ]
do
    i=$[$i-2]
    echo -n '\x' >> output.txt
    echo -n ${v:$i:2} >> output.txt
done

printf $(cat output.txt)
rm output.txt
