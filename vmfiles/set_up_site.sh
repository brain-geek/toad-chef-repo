#!/bin/bash
HOSTNAME=$1
IP=$2

echo 'Run me as user, please!'

sudo ./createvm.sh $HOSTNAME $IP

sleep 30

knife bootstrap $IP -x brain -N $HOSTNAME -P password -r 'role[simple_webserver]' --sudo