#!/bin/bash

senderaddr="B62qpSphT9prqYrJFio82WmV3u29DkbzGprLAM3pZQM2ZEaiiBmyY82"
receiveraddr="B62qqtwygyMDh56idVbEAWRzaJCMFg3EXBnUcohZbBemaH6W2HmmG3b"

echo ">>>>>>>>Start Sending Transaction<<<<<<<<"
echo ""

for ((i = 0 ; i < 100 ; i++)); do
    amount=$(( $RANDOM %100 ))
    amount=$( bc <<< "scale=9;$amount/333" )

    fee=$(( $RANDOM %100 ))
    fee=$( bc <<< "scale=9;$fee/333" )
    echo "In" $i "transaction sent" $amount "Mina with fee" $fee

    docker exec -it mina mina client send-payment \
         -amount $amount \
         -receiver $receiveraddr \
         -fee $fee \
         -sender $senderaddr
    sleep $[ (5 + $RANDOM % 60 ) ]s

echo "----------------------------"
done
echo ""
echo ">>>>>>>>End Sending<<<<<<<<"