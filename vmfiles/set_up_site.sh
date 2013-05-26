#!/bin/bash

if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as user" 1>&2
   exit 1  
fi

usage()
{
cat << EOF
usage: $0 options

This script creates and sets up VM.

OPTIONS:
   -h      Show this message
   -i      IP for server
   -n      hostName for server
   -r      Role to assign to node (simple_webserver by default)
   -m      Amount of memory in MB (128 by default)
   -c      Amount of CPUs (1 by default)
EOF
}

HOSTNAME=
IP=
ROLE=simple_webserver
MEMORY=128
CPUS=1

while getopts “hn:i:” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         n)
             HOSTNAME=$OPTARG
             ;;
         i)
             IP=$OPTARG
             ;;
         r)
             ROLE=$OPTARG
             ;;
         c)
             CPUS=$OPTARG
             ;;
         m)  
             MEMORY=$OPTARG
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

if [[ -z $IP ]] || [[ -z $HOSTNAME ]]
then
     usage
     exit 1
fi


echo "Creating VM with hostname: $HOSTNAME and ip: $IP"

sudo bash -c "vmbuilder kvm ubuntu -d /virt/$HOSTNAME --ip $IP -o --hostname $HOSTNAME -c vmbuilder.cfg -m $MEMORY --cpus $CPUS --user brain --name user --pass password && virsh start $HOSTNAME"

sleep 30

sudo "Bootstrapping VM with Chef"

knife bootstrap $IP -x brain -N $HOSTNAME -P password --sudo

knife node run_list add $HOSTNAME "role[$ROLE]"

sleep 15

knife ssh name:$HOSTNAME "sudo chef-client" -x brain -a ipaddress -P password