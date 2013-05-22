#!/bin/bash
HOSTNAME=$1
IP=$2

echo 'Run me as user, please!'

sudo ./createvm.sh $HOSTNAME $IP

sleep 30

knife bootstrap $IP -x brain -N $HOSTNAME -P password --sudo

knife node run_list add $HOSTNAME 'role[simple_webserver]'
knife ssh name:$HOSTNAME "sudo chef-client" -x brain -a ipaddress -P password