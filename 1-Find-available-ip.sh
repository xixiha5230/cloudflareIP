#!/bin/bash

read -p "Please set the number of PING cycles[default:100 times]:" num
num=${num:-100}
read -p "Please set the PING interval time[default:0s]:" interval
interval=${interval:-0}
echo "Test packet loss rate from ip.txt file" 
fping -f ip.txt -c $num --interval=$interval -s > ping.csv
sort -k 1.1,1.14 ping.csv | uniq -c -w 14 > temp.csv
sort -n -k 1.42,1.46 temp.csv -o temp.csv
head -30  temp.csv > ping.csv
#sort -r -b -n  ping.csv -o ping.csv
cat ping.csv > sort.txt
sed -i '1i  number     IP                             delay                                ' sort.txt
rm ip.txt ping.csv temp.csv
cat sort.txt
