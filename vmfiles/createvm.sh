#!/bin/bash
HOSTNAME=$1
IP=$2

echo "Creating VM with hostname: $HOSTNAME and ip: $IP"

vmbuilder kvm ubuntu -d /virt/$HOSTNAME --ip $IP -o --hostname $HOSTNAME -c vmbuilder.cfg
virsh start $HOSTNAME

echo "Done."