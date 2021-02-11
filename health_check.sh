#!/bin/bash

# This script reports the disk and RAM usage on the provided endpoints. Endpoints must be
# provided in ssh format (<user>@<ipaddr>) with key based authentication set up prior

list=$1

if [ "$list" = "" ]
then
  echo "Please specify a list of endpoints in ssh format (<user>@<ipaddr>)"
  exit 10
elif test -e $list
then
  mkdir ~/log 2> /dev/null
  touch ~/log/endpoint_health.txt
  date >> ~/log/endpoint_health.txt
  for endpoint in `cat $list`
  do
    echo "Querying $endpoint..."
    ssh $endpoint hostname >> ~/log/endpoint_health.txt
    ssh $endpoint df -h >> ~/log/endpoint_health.txt
    ssh $endpoint free -h >> ~/log/endpoint_health.txt
    echo "" >> ~/log/endpoint_health.txt
  done
  exit 20
else
  echo "Invalid file specified"
  exit 30
fi
