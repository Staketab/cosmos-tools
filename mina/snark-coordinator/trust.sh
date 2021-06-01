#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
ST="\033[0m"

if [ "$IP" == "" ]; then
    IP=""
fi

if [ "$IP2" == "" ]; then
    IP2=""
fi

if [ "$IP3" == "" ]; then
    IP3=""
fi

if [ "$IP4" == "" ]; then
    IP4=""
fi

echo "---------------"
echo -e "$GREEN Start Checking Node Status.$ST"
echo "---------------"

while true; do

sudo docker exec root_coordinator_1 mina advanced client-trustlist add -ip-address ${IP}/32
echo""
sudo docker exec root_coordinator_1 mina advanced client-trustlist add -ip-address ${IP2}/32
echo""
sudo docker exec root_coordinator_1 mina advanced client-trustlist add -ip-address ${IP3}/32
echo""
sudo docker exec root_coordinator_1 mina advanced client-trustlist add -ip-address ${IP4}/32
echo""

echo "---------------"
echo -e "$GREEN Trust list updated.$ST"
echo "---------------"

sleep 300s

echo "----------------------------"
echo ""
done
