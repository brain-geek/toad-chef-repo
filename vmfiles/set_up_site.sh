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
EOF
}

HOSTNAME=
IP=

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

sudo vmbuilder kvm ubuntu -d /virt/$HOSTNAME --ip $IP -o --hostname $HOSTNAME -c vmbuilder.cfg --user brain --name user --pass password
sudo virsh start $HOSTNAME

sleep 30

sudo "Bootstrapping VM with Chef"

knife bootstrap $IP -x brain -N $HOSTNAME -P password --sudo

knife node run_list add $HOSTNAME 'role[simple_webserver]'

sleep 15

knife ssh name:$HOSTNAME "sudo chef-client" -x brain -a ipaddress -P password