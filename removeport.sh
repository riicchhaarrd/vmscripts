#!/bin/bash
ip=$1
realport=$2
fakeport=$3
echo "Disabling port $realport:$fakeport on $ip"
#iptables -t nat -D POSTROUTING -s "$ip/24" -o vmbr0 -j MASQUERADE
iptables -t nat -D PREROUTING -i vmbr0 -p tcp --dport $fakeport -j DNAT --to $ip:$realport