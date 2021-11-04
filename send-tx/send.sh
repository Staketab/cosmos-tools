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
  sendCount "${4}"
  rpcport "${5}"
}

function binary {
  BINARY=${1}
}

function keyname {
  KEY_NAME=${1}
}

function sleepTime {
  STIME=${1:-"5s"}
}

function sendCount {
  COUNT=${1:-"100"}
}

function rpcport {
  RPC_PORT=${1:-"26657"}
}

function launch {
setup "${1}" "${2}" "${3}" "${4}" "${5}"
echo "-------------------------------------------------------------------"
echo -e "$YELLOW Enter PASSWORD for your KEY $NORMAL"
echo "-------------------------------------------------------------------"
read -s PASS

COIN=$(curl -s http://localhost:${RPC_PORT}/genesis | jq -r .result.genesis.app_state.crisis.constant_fee.denom)
echo -e "$GREEN Enter Fees in ${COIN}.$NORMAL"
read -p "FEES: " FEES
echo -e "$GREEN Enter receiver address.$NORMAL"
read -p "RECEIVER ADDRESS: " REC
FEE=${FEES}${COIN}
ADDRESS=$(echo $PASS | ${BINARY} keys show ${KEY_NAME} --output json | jq -r '.address')
VALOPER=$(echo $PASS | ${BINARY} keys show ${ADDRESS} -a --bech val)
CHAIN=$(${BINARY} status --node http://localhost:${RPC_PORT} 2>&1 | jq -r .NodeInfo.network)
SENDER=${ADDRESS}
RECEIVER=${REC}

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Check you Validator data: $NORMAL"
echo -e "$GREEN Address: $ADDRESS $NORMAL"
echo -e "$GREEN Valoper: $VALOPER $NORMAL"
echo -e "$GREEN Chain: $CHAIN $NORMAL"
echo -e "$GREEN Coin: $COIN $NORMAL"
echo -e "$GREEN Key Name: $KEY_NAME $NORMAL"
echo -e "$GREEN Sleep Time: $STIME $NORMAL"
echo "-------------------------------------------------------------------"
echo -e "$GREEN Receiver Address: $ADDRESS $NORMAL"
echo "-------------------------------------------------------------------"
echo -e "$YELLOW If your Data is right type$RED yes$NORMAL.$NORMAL"
echo -e "$YELLOW If your Data is wrong type$RED no$NORMAL$YELLOW and check it.$NORMAL $NORMAL"
read -p "Your answer: " ANSWER

if [ "$ANSWER" == "yes" ]; then
    SEQ=$(${BINARY} query account ${SENDER} --output json | jq -r .sequence)
      for ((i = 0 ; i < ${COUNT} ; i++)); do
        AMOUNT=$(( $RANDOM %100 ))
        AMOUNT=$(( AMOUNT+5 ))
        echo $SEQ
        CUR_BLOCK=$(curl -s http://localhost:${RPC_PORT}/abci_info | jq -r .result.response.last_block_height)
        TX=$(echo $PASS | ${BINARY} tx bank send ${SENDER} ${RECEIVER} ${AMOUNT}${COIN} --chain-id=${CHAIN} --from ${KEY_NAME} --fees ${FEE} --node http://localhost:${RPC_PORT} --sequence ${SEQ} --timeout-height $(($CUR_BLOCK + 5)) -y | grep "raw_log")
          if [ "$TX" == *"incorrect"* ]; then
            SEQ=$(($SEQ+1))
            echo $PASS | ${BINARY} tx bank send ${SENDER} ${RECEIVER} ${AMOUNT}${COIN} --chain-id=${CHAIN} --from ${KEY_NAME} --fees ${FEE} --node http://localhost:${RPC_PORT} --sequence ${SEQ} --timeout-height $(($CUR_BLOCK + 5)) -y | grep "raw_log\|txhash"
            sleep 10
          else
            echo $PASS | ${BINARY} tx bank send ${SENDER} ${RECEIVER} ${AMOUNT}${COIN} --chain-id=${CHAIN} --from ${KEY_NAME} --fees ${FEE} --node http://localhost:${RPC_PORT} --sequence ${SEQ} --timeout-height $(($CUR_BLOCK + 5)) -y | grep "raw_log\|txhash"
          fi
        SEQ=$(($SEQ+1))
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

while getopts ":b:k:s:c:p:" o; do
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
    c)
      c=${OPTARG}
      ;;
    p)
      p=${OPTARG}
      ;;
  esac
done
shift $((OPTIND-1))

launch "${b}" "${k}" "${s}" "${c}" "${p}"
