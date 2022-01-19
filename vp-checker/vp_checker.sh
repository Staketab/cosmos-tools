#!/bin/bash

curl -s https://raw.githubusercontent.com/Staketab/node-tools/main/logo.sh | bash

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
NORMAL="\033[0m"

function line {
    echo "-------------------------------------------------------------------"
}
function setup {
  binary "${1}"
  sleepTime "${2}"
  rpcport "${3}"
  tgtoken "${4}"
  tgchatid "${5}"
  discordhook "${6}"
}
function binary {
  BINARY=${1}
}
function sleepTime {
  STIME=${1:-"10s"}
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
function discordhook {
  DISCORD_HOOK=${1}
}
function sendTg {
  if [[ ${TG_TOKEN} != "" ]]; then
    local tg_msg="$@"
    curl -s -H 'Content-Type: application/json' --request 'POST' -d "{\"chat_id\":\"${TG_CHAT_ID}\",\"text\":\"${tg_msg}\"}" "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" -so /dev/null
  fi
}
function sendDiscord {
  if [[ ${DISCORD_HOOK} != "" ]]; then
    local discord_msg="$@"
    curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$discord_msg\"}" $DISCORD_HOOK -so /dev/null
  fi
}

function launch {
setup "${1}" "${2}" "${3}" "${4}" "${5}" "${6}"

line
echo -e "$GREEN Start checking Voting Power... $NORMAL"
line

while true
do

POWER=$(curl -s http://localhost:${RPC_PORT}/status | jq -r ".result.validator_info.voting_power")
sleep $STIME

NEW_POWER=$(curl -s http://localhost:${RPC_PORT}/status | jq -r ".result.validator_info.voting_power")
if [ "$NEW_POWER" -eq "$POWER" ]; then
  line
  echo -e "$YELLOW No changes in Voting Power... $NORMAL"
  line
elif [ "$NEW_POWER" -gt "$POWER" ]; then
  CURRENT_VP="$((NEW_POWER - POWER))"
  echo -e "$YELLOW VP increased by:$NORMAL$GREEN $CURRENT_VP $NORMAL"
  line
  MSG=$(echo -e "${BINARY} | $HOSTNAME | $(date +%F-%H-%M-%S) | VP increased: $CURRENT_VP")
  sendTg ${MSG}
  sendDiscord ${MSG}
elif [ "$NEW_POWER" -lt "$POWER" ]; then
  CURRENT_VP="$((NEW_POWER - POWER))"
  echo -e "$YELLOW VP decreased by:$NORMAL$GREEN $CURRENT_VP $NORMAL"
  line
  MSG=$(echo -e "${BINARY} | $HOSTNAME | $(date +%F-%H-%M-%S) | VP decreased: $CURRENT_VP")
  sendTg ${MSG}
  sendDiscord ${MSG}
else
  echo -e "$RED Something wrong. Exited...$NORMAL"
  exit 0
fi
done
}

while getopts ":b:s:p:t:c:d:" o; do
  case "${o}" in
    b)
      b=${OPTARG}
      ;;
    s)
      s=${OPTARG}
      ;;
    p)
      c=${OPTARG}
      ;;
    t)
      t=${OPTARG}
      ;;
    c)
      c=${OPTARG}
      ;;
    d)
      d=${OPTARG}
      ;;
  esac
done
shift $((OPTIND-1))

launch "${b}" "${s}" "${p}" "${t}" "${c}" "${d}"
