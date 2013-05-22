#!/bin/bash
HOSTNAME=$1
IP=$2

bash vmfiles/createvm.sh $HOSTNAME $IP
knife bootstrap $IP -x brain -N $HOSTNAME-toad -P password -r 'role[simple_webserver]' --sudo