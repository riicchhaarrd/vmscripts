#!/bin/bash
echo 1 > /proc/sys/net/ipv4/ip_forward
ip=$1
realport=$2
fakeport=$3
echo "Enabling port $realport to $fakeport on $ip"
#iptables -t nat -A POSTROUTING -s '192.168.50.69/24' -o vmbr0 -j MASQUERADE
#iptables -t nat -A POSTROUTING -s "$ip/24" -o vmbr0 -j MASQUERADE
# removal
#iptables -t nat -D POSTROUTING -s '192.168.50.69/24' -o vmbr0 -j MASQUERADE

# port forward single port
iptables -t nat -A PREROUTING -i vmbr0 -p tcp --dport $fakeport -j DNAT --to $ip:$realport
# removal
#iptables -t nat -D PREROUTING -i vmbr0 -p tcp --dport 8000 -j DNAT --to 192.168.50.69:8000