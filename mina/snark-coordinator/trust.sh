#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
ST="\033[0m"

if [ "$IP" == "" ]; then
    exit
fi

if [ "$IP2" == "" ]; then
    exit
fi

if [ "$IP3" == "" ]; then
    exit
fi

if [ "$IP4" == "" ]; then
    exit
fi

echo "---------------"
echo -e "$GREEN Start Checking Node Status.$ST"
echo "---------------"

while true; do

docker exec root_coordinator_1 mina advanced client-trustlist add -ip-address ${IP}/32 \n
docker exec root_coordinator_1 mina advanced client-trustlist add -ip-address ${IP2}/32 \n
docker exec root_coordinator_1 mina advanced client-trustlist add -ip-address ${IP3}/32 \n
docker exec root_coordinator_1 mina advanced client-trustlist add -ip-address ${IP4}/32 \n

echo "---------------"
echo -e "$GREEN Trust list updated.$ST"
echo "---------------"

sleep 300s

echo "----------------------------"
echo ""
done
