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

BINARY=$1
KEY_NAME=$2
RPC_PORT=$3

if [[ ${RPC_PORT} == "" ]]; then
  RPC_PORT=26657
fi

set -u

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Enter PASSWORD for your KEY $NORMAL"
echo "-------------------------------------------------------------------"
read -s PASS


COIN=$(curl -s http://localhost:${RPC_PORT}/genesis | jq -r .result.genesis.app_state.crisis.constant_fee.denom)
FEE=5000${COIN}
ADDRESS=$(echo $PASS | ${BINARY} keys show ${KEY_NAME} --output json | jq -r '.address')
VALOPER=$(echo $PASS | ${BINARY} keys show ${ADDRESS} -a --bech val)
CHAIN=$(${BINARY} status 2>&1 | jq -r .NodeInfo.network)

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Check you Validator data: $NORMAL"
echo -e "$GREEN Address: $ADDRESS $NORMAL"
echo -e "$GREEN Valoper: $VALOPER $NORMAL"
echo -e "$GREEN Chain: $CHAIN $NORMAL"
echo -e "$GREEN Coin: $COIN $NORMAL"
echo -e "$GREEN Key Name: $KEY_NAME $NORMAL"
echo "-------------------------------------------------------------------"
echo -e "$YELLOW If your Data is right type$RED yes$NORMAL.$NORMAL"
echo -e "$YELLOW If your Data is wrong type$RED no$NORMAL$YELLOW and check it.$NORMAL $NORMAL"
read -p "Your answer: " ANSWER

if [ "$ANSWER" == "yes" ]; then
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
elif [ "$ANSWER" == "no" ]; then
    echo -e "$RED Exited...$NORMAL"
    exit 0
else
    echo -e "$RED Answer wrong. Exited...$NORMAL"
    exit 0
fi
done
