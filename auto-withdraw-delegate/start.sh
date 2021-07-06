#!/bin/bash

echo ""
echo "░██████╗████████╗░█████╗░██╗░░██╗███████╗████████╗░█████╗░██████╗░░░░░█████╗░░█████╗░███╗░░░███╗"
echo "██╔════╝╚══██╔══╝██╔══██╗██║░██╔╝██╔════╝╚══██╔══╝██╔══██╗██╔══██╗░░░██╔══██╗██╔══██╗████╗░████║"
echo "╚█████╗░░░░██║░░░███████║█████═╝░█████╗░░░░░██║░░░███████║██████╦╝░░░██║░░╚═╝██║░░██║██╔████╔██║"
echo "░╚═══██╗░░░██║░░░██╔══██║██╔═██╗░██╔══╝░░░░░██║░░░██╔══██║██╔══██╗░░░██║░░██╗██║░░██║██║╚██╔╝██║"
echo "██████╔╝░░░██║░░░██║░░██║██║░╚██╗███████╗░░░██║░░░██║░░██║██████╦╝██╗╚█████╔╝╚█████╔╝██║░╚═╝░██║"
echo "╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝╚═════╝░╚═╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝"
echo ""

sleep 1

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
NORMAL="\033[0m"

COIN=$1
BINARY=$2
KEY_NAME=$3

if [ "$COIN" == "" ]; then
    exit
fi

if [ "$BINARY" == "" ]; then
    exit
fi

if [ "$KEY_NAME" == "" ]; then
    exit
fi

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Enter PASSWORD for your KEY $NORMAL"
echo "-------------------------------------------------------------------"
read -s PASS

FEE=5000${COIN}
ADDRESS=$(echo $PASS | ${BINARY} keys show ${KEY_NAME} --output json | jq -r '.address')
VALOPER=$(echo $PASS | ${BINARY} keys show ${ADDRESS} -a --bech val)
CHAIN=$(${BINARY} status 2>&1 | jq -r .NodeInfo.network)

while true
do
    echo "-------------------------------------------------------------------"
    echo -e "$RED$(date)$NORMAL $YELLOW Withdraw commission and rewards $NORMAL"
    echo "-------------------------------------------------------------------"
    echo $PASS | ${BINARY} tx distribution withdraw-rewards ${VALOPER} --commission --from ${KEY_NAME} --gas auto --chain-id=${CHAIN} --fees ${FEE} -y | grep "raw_log\|txhash"

    sleep 1m

    AMOUNT=$(${BINARY} query bank balances ${ADDRESS} --chain-id=${CHAIN} --output json | jq -r '.balances[0].amount')
    DELEGATE=$((AMOUNT - 1000000))

    if [[ $DELEGATE > 0 && $DELEGATE != "null" ]]; then
    echo "-------------------------------------------------------------------"
    echo -e "$RED$(date)$NORMAL $YELLOW Stake ${DELEGATE} ${COIN} $NORMAL"
    echo "-------------------------------------------------------------------"
    echo $PASS | ${BINARY} tx staking delegate ${VALOPER} ${DELEGATE}${COIN} --chain-id=${CHAIN} --from ${KEY_NAME} --fees ${FEE} -y | grep "raw_log\|txhash"
    else
    echo "-------------------------------------------------------------------"
    echo -e "$RED Insufficient balance for delegation $NORMAL"
    echo "-------------------------------------------------------------------"
    fi
    echo "-------------------------------------------------------------------"
    echo -e "$GREEN Sleep for 60 minutes $NORMAL"
    echo "-------------------------------------------------------------------"
    sleep 60m
done
