#!/bin/bash

IP=$1
FOLDER=$2

touch sitemap

mkdir -p $FOLDER

for i in $(seq 20); do
  echo "Running $((5*$i))"
  rm sitemap&&wget http://$IP/sitemap&&siege -i -f sitemap -c $((5*$i)) -t 1M &> $FOLDER/siege-$((5*$i)).log
done