#!/bin/bash

curl -s https://raw.githubusercontent.com/Staketab/node-tools/main/logo.sh | bash

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
NORMAL="\033[0m"

function setup {
  binary "${1}"
  keyname "${2}"
  sleepTime "${3}"
  rpcport "${4}"
  tgtoken "${5}"
  tgchatid "${6}"
}

function binary {
  BINARY=${1}
}

function keyname {
  KEY_NAME=${1}
}

function sleepTime {
  STIME=${1:-"60m"}
}

function rpcport {
  RPC_PORT=${1:-"26657"}
}

function tgtoken {
  TG_TOKEN=${1}
}
function tgchatid {
  TG_CHAT_ID=${1}
}

function sendTg {
  if [[ ${TG_TOKEN} != "" ]]; then
    local tg_msg="$@"
    curl -s -H 'Content-Type: application/json' --request 'POST' -d "{\"chat_id\":\"${TG_CHAT_ID}\",\"text\":\"${tg_msg}\"}" "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" -so /dev/null
  fi
}

function launch {
setup "${1}" "${2}" "${3}" "${4}" "${5}" "${6}"
echo "-------------------------------------------------------------------"
echo -e "$YELLOW Enter PASSWORD for your KEY $NORMAL"
echo "-------------------------------------------------------------------"
read -s PASS

COIN=$(${BINARY} q staking params --node tcp://localhost:${RPC_PORT} -o j | jq -r '.bond_denom')
echo -e "$GREEN Enter Fees in ${COIN}.$NORMAL"
read -p "Fees: " FEES
FEE=${FEES}${COIN}
echo -e "$GREEN Enter how much tokens to leave at the address after delegation.$NORMAL$RED Example: 1000000$NORMAL"
read -p "Tokens: " COINS
ADDRESS=$(echo $PASS | ${BINARY} keys show ${KEY_NAME} --output json | jq -r '.address')
VALOPER=$(echo $PASS | ${BINARY} keys show ${ADDRESS} -a --bech val)
CHAIN=$(${BINARY} status --node tcp://localhost:${RPC_PORT} 2>&1 | jq -r .NodeInfo.network)

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Check you Validator data: $NORMAL"
echo -e "$GREEN Address: $ADDRESS $NORMAL"
echo -e "$GREEN Valoper: $VALOPER $NORMAL"
echo -e "$GREEN Chain: $CHAIN $NORMAL"
echo -e "$GREEN Coin: $COIN $NORMAL"
echo -e "$GREEN Key Name: $KEY_NAME $NORMAL"
echo -e "$GREEN Sleep Time: $STIME $NORMAL"
echo "-------------------------------------------------------------------"
echo -e "$YELLOW If your Data is right type$RED yes$NORMAL.$NORMAL"
echo -e "$YELLOW If your Data is wrong type$RED no$NORMAL$YELLOW and check it.$NORMAL $NORMAL"
read -p "Your answer: " ANSWER

if [ "$ANSWER" == "yes" ]; then
    while true
    do
    echo "-------------------------------------------------------------------"
    echo -e "$RED$(date +%F-%H-%M-%S)$NORMAL $YELLOW Withdraw commission and rewards $NORMAL"
    echo "-------------------------------------------------------------------"
    echo $PASS | ${BINARY} tx distribution withdraw-rewards ${VALOPER} --commission --from ${KEY_NAME} --gas auto --gas-adjustment 1.5 --chain-id=${CHAIN} --fees ${FEE} --node tcp://localhost:${RPC_PORT} -y | grep "raw_log\|txhash"

    sleep 1m

    AMOUNT=$(${BINARY} query bank balances ${ADDRESS} --chain-id=${CHAIN} --node tcp://localhost:${RPC_PORT} --output json | jq -r '.balances[0].amount')
    DELEGATE=$((AMOUNT - ${COINS}))

    if [[ $DELEGATE > 0 && $DELEGATE != "null" ]]; then
        echo "-------------------------------------------------------------------"
        echo -e "$RED$(date +%F-%H-%M-%S)$NORMAL $YELLOW Stake ${DELEGATE} ${COIN} $NORMAL"
        echo "-------------------------------------------------------------------"
        echo $PASS | ${BINARY} tx staking delegate ${VALOPER} ${DELEGATE}${COIN} --chain-id=${CHAIN} --from ${KEY_NAME} --gas auto --gas-adjustment 1.5 --fees ${FEE} --node tcp://localhost:${RPC_PORT} -y | grep "raw_log\|txhash"
        sleep 30s
        echo "-------------------------------------------------------------------"
        echo -e "$GREEN Balance after delegation:$NORMAL"
        BAL=$(${BINARY} query bank balances ${ADDRESS} --chain-id=${CHAIN} --node tcp://localhost:${RPC_PORT} --output json | jq -r '.balances[0].amount')
        echo -e "$YELLOW ${BAL} ${COIN} $NORMAL"
        MSG=$(echo -e "${BINARY} | $(date +%F-%H-%M-%S) | Delegated: ${DELEGATE} ${COIN} | Balance after delegation: ${BAL} ${COIN}")
        sendTg ${MSG}
    else
        MSG=$(echo -e "${BINARY} | $(date +%F-%H-%M-%S) | Insufficient balance for delegation")
        sendTg ${MSG}
        echo "-------------------------------------------------------------------"
        echo -e "$RED Insufficient balance for delegation $NORMAL"
        echo "-------------------------------------------------------------------"
    fi
        echo "-------------------------------------------------------------------"
        echo -e "$GREEN Sleep for ${STIME} $NORMAL"
        echo "-------------------------------------------------------------------"
        sleep ${STIME}
    done
elif [ "$ANSWER" == "no" ]; then
    echo -e "$RED Exited...$NORMAL"
    exit 0
else
    echo -e "$RED Answer wrong. Exited...$NORMAL"
    exit 0
fi
}

while getopts ":b:k:s:p:t:c:" o; do
  case "${o}" in
    b)
      b=${OPTARG}
      ;;
    k)
      k=${OPTARG}
      ;;
    s)
      s=${OPTARG}
      ;;
    p)
      p=${OPTARG}
      ;;
    t)
      t=${OPTARG}
      ;;
    c)
      c=${OPTARG}
      ;;
  esac
done
shift $((OPTIND-1))

launch "${b}" "${k}" "${s}" "${p}" "${t}" "${c}"
