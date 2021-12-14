id=$1
#remove the nat
iptables -t nat -D POSTROUTING -s "192.168.$id.2/24" -o vmbr0 -j MASQUERADE

qm stop $id
br="br$id"
ip link set $br down
ip link del $br
qm destroy $id