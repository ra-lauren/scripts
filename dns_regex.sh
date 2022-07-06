#!/bin/bash

echo "Enter keyword you'd like to search valid domains with: "
read keyword
#
#servers=(
#"whois.crsnic.net"
#)

# Works
# "whois.verisign-grs.net"

# Does not work
#"whois.intermic.net"

#for server in ${servers[@]}; do
#    whois -h $server $keyword* | grep Dom | cut -d ' ' -f 3 | tee -a results
#done

#curl -i -s -k -X $'GET' \
#    -H $'Host: www.namedroppers.com' -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101 Firefox/91.0' -H $'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H $'Accept-Language: en-US,en;q=0.5' -H $'Accept-Encoding: gzip, deflate' -H $'Upgrade-Insecure-Requests: 1' -H $'Sec-Fetch-Dest: document' -H $'Sec-Fetch-Mode: navigate' -H $'Sec-Fetch-Site: none' -H $'Sec-Fetch-User: ?1' -H $'Cache-Control: max-age=0' -H $'Te: trailers' -H $'Connection: close' \
#    -b $'tlds=255' \
#    $'https://www.namedroppers.com/b/q?adv=1&k=covid&x=23&y=25&exclude=&order=0&min=1&max=63&org=1'


chars=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9 - _ )
array_dns_srvrs=(`cat list_publicdns.txt`)
len_array_dns=${#array_dns_srvrs[@]}
counter=0


for a in ${chars[@]}; do
    for b in ${chars[@]}; do
        for c in ${chars[@]}; do
            dig $a$b$c$keyword.com ${array_dns_srvrs[$counter]} | grep -A 2 "ANSWER SEC" | grep -v "ANS" | tee -a results_dig.txt &
            ((counter++))
            if (($counter >= $len_array_dns))
            then
                counter=0
            fi
        done
    done
done