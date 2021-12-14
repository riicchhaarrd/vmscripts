#!/bin/bash
newid=$2
newname="vm$newid"
templateid=$1
echo "Creating new VM $newid from template $templateid"
qm clone $templateid $newid --name $newname
qm set $newid --ipconfig0 ip=192.168.$newid.2/24,gw=192.168.$newid.1
#qm set $newid --ipconfig0 ip=dhcp
# only for cloudinit
qm set $newid --cipassword password
# todo resize it in the template
#qm resize $newid scsi0 +5G

# create network for vm
br="br$newid"
ip link add name $br type bridge
ip addr add 192.168.$newid.1 dev $br
ip link set $br up
ip route add 192.168.$newid.0/24 via 192.168.$newid.1 dev $br

# add nat forwarding
iptables -t nat -A POSTROUTING -s "192.168.$newid.2/24" -o vmbr0 -j MASQUERADE

qm set $newid --net0 virtio,bridge=$br
qm start $newid