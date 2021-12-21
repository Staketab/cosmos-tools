#!/bin/bash

curl -s https://raw.githubusercontent.com/Staketab/node-tools/main/logo.sh | bash

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
NORMAL="\033[0m"
LOG_FILE_TO_ETH="$HOME/to_eth_hashes.log"
LOG_FILE_TO_COSMOS="$HOME/to_cosmos_hashes.log"

function line {
    echo "-------------------------------------------------------------------"
}

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
  STIME=${1:-"3s"}
}

function sendCount {
  COUNT=${1:-"50"}
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
ADDRESS=$(echo $PASS | ${BINARY} keys show ${KEY_NAME} --output json | jq -r '.address')
VALOPER=$(echo $PASS | ${BINARY} keys show ${ADDRESS} -a --bech val)
CHAIN=$(${BINARY} status --node http://localhost:${RPC_PORT} 2>&1 | jq -r .NodeInfo.network)
SENDER=${ADDRESS}

function log_this_to_eth {
    local logging="$@"
    printf "$logging\n" | sudo tee -a ${LOG_FILE_TO_ETH}
}
function log_this_to_cosmos {
    local logging="$@"
    printf "$logging\n" | sudo tee -a ${LOG_FILE_TO_COSMOS}
}
function mainChecks {
echo "-------------------------------------------------------------------"
echo -e "$YELLOW Check you Validator data: $NORMAL"
echo -e "$GREEN Sender address: $ADDRESS $NORMAL"
echo -e "$GREEN Valoper: $VALOPER $NORMAL"
echo -e "$GREEN Chain: $CHAIN $NORMAL"
echo -e "$GREEN Coin: $COIN $NORMAL"
echo -e "$GREEN Key Name: $KEY_NAME $NORMAL"
echo -e "$GREEN Sleep Time: $STIME $NORMAL"
echo "-------------------------------------------------------------------"
echo -e "$GREEN Receiver Address: $REC $NORMAL"
echo "-------------------------------------------------------------------"
echo -e "$YELLOW If your Data is right type$RED yes$NORMAL.$NORMAL"
echo -e "$YELLOW If your Data is wrong type$RED no$NORMAL$YELLOW and check it.$NORMAL $NORMAL"
read -p "Your answer: " ANSWER  
}
function checks {
echo -e "$GREEN Enter receiver address.$NORMAL"
read -p "RECEIVER ADDRESS: " REC
RECEIVER=${REC}
mainChecks
}
function checksEth {
echo -e "$GREEN Enter receiver address.$NORMAL"
read -p "RECEIVER ADDRESS: " REC
RECEIVER=${REC}
echo -e "$GREEN Enter ETH Private key.$NORMAL"
read -p "ETH PRIVATE KEY: " ETH_PK_CLEAN_SEND
echo -e "$GREEN Enter ETH RPC.$NORMAL"
read -p "ETH RPC: " ETH_RPC_SEND
mainChecks
}
function choises {
line
echo -e "$GREEN CHOOSE SENDING WAY: $NORMAL"
echo -e "$RED 1$NORMAL -$YELLOW From Cosmos to ETH$NORMAL"
echo -e "$RED 2$NORMAL -$YELLOW From ETH to Cosmos$NORMAL"
line
read -p "Answer: " CHOISE
}
choises
if [ "$CHOISE" == "1" ]; then
  checks
  if [ "$ANSWER" == "yes" ]; then
      SEQ=$(${BINARY} query account ${SENDER} --node http://localhost:${RPC_PORT} --output json | jq -r .sequence)
        for ((i = 0 ; i < ${COUNT} ; i++)); do
          AMOUNT=$(( $RANDOM %100000 ))
          echo -e "$YELLOW Sequence$NORMAL$RED $SEQ $NORMAL"
          CUR_BLOCK=$(curl -s http://localhost:${RPC_PORT}/abci_info | jq -r .result.response.last_block_height)
          TX=$(echo $PASS | ${BINARY} tx peggy send-to-eth ${RECEIVER} ${AMOUNT}${COIN} 1uumee --from ${KEY_NAME} --chain-id=${CHAIN} --node http://localhost:${RPC_PORT} --sequence ${SEQ} --timeout-height $(($CUR_BLOCK + 5)) -y | jq -r '.txhash,.code')
          log_this_to_eth "$TX"
          SEQ=$(($SEQ+1))
          sleep ${STIME}
        done
        echo -e "$GREEN done in file$NORMAL$RED $LOG_FILE_TO_ETH $NORMAL"
  elif [ "$ANSWER" == "no" ]; then
      echo -e "$RED Exited...$NORMAL"
      exit 0
  else
      echo -e "$RED Answer wrong. Exited...$NORMAL"
      exit 0
  fi
elif [ "$CHOISE" == "2" ]; then
checksEth
  if [ "$ANSWER" == "yes" ]; then
        for ((i = 0 ; i < ${COUNT} ; i++)); do
          AMOUNT=$(( $RANDOM %50000 ))
          mkdir -p $HOME/tmp
          TX=$(peggo bridge send-to-cosmos 0xe54fbaecc50731afe54924c40dfd1274f718fe02 ${RECEIVER} ${AMOUNT} --eth-pk=${ETH_PK_CLEAN_SEND} --eth-rpc=${ETH_RPC_SEND} --tendermint-rpc http://localhost:${RPC_PORT} &>> $HOME/tmp/dump.txt)
          TX2=$(cat $HOME/tmp/dump.txt | jc --kv -p | jq -r '.transaction')
          log_this_to_cosmos "$TX2"
          rm -rf $HOME/tmp/dump.txt
          sleep ${STIME}
        done
        echo -e "$GREEN done in file$NORMAL$RED $LOG_FILE_TO_COSMOS $NORMAL"
  elif [ "$ANSWER" == "no" ]; then
      echo -e "$RED Exited...$NORMAL"
      exit 0
  else
      echo -e "$RED Answer wrong. Exited...$NORMAL"
      exit 0
  fi
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
