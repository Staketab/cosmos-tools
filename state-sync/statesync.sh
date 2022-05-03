#!/bin/bash

curl -s https://raw.githubusercontent.com/Staketab/node-tools/main/logo.sh | bash

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
NORMAL="\033[0m"
RPC=${1}
CONFIG_FOLDER=${2}
SERVICE_NAME=${3}
BLOCKS=${4}
SERVERIP="$(curl ifconfig.me)"

line() {
  echo "-------------------------------------------------------------------"
}
backup() {
  line
  echo -e "$YELLOW Deleting old data...$NORMAL"
  cd $HOME/${CONFIG_FOLDER}/data/; ls | grep -v 'priv_validator_state.json\|upgrade-info.json' | xargs rm -rf; cd
}
statesync() {
  line
  LATEST_HEIGHT=$(curl -s ${RPC}/block | jq -r .result.block.header.height)
  TRUST_HEIGHT=$((LATEST_HEIGHT - ${BLOCKS}))
  TRUST_HASH=$(curl -s "${RPC}/block?height=$TRUST_HEIGHT" | jq -r .result.block_id.hash)
  echo -e "$YELLOW RPC SERVERS:$NORMAL$RED ${RPC},${RPC}$NORMAL"
  echo -e "$YELLOW TRUST_HEIGHT:$NORMAL$RED ${TRUST_HEIGHT}$NORMAL"
  echo -e "$YELLOW TRUST_HASH:$NORMAL$RED ${TRUST_HASH}$NORMAL"
  line
  sleep 3

  sed -i.bak -E 's#^(rpc_servers[[:space:]]+=[[:space:]]+).*$#\1"'$RPC','$RPC'"#' $HOME/${CONFIG_FOLDER}/config/config.toml
  sed -i.bak -E 's#^(trust_height[[:space:]]+=[[:space:]]+).*$#\1"'$TRUST_HEIGHT'"#' $HOME/${CONFIG_FOLDER}/config/config.toml
  sed -i.bak -E 's#^(trust_hash[[:space:]]+=[[:space:]]+).*$#\1"'$TRUST_HASH'"#' $HOME/${CONFIG_FOLDER}/config/config.toml
  #sed -i.bak -E 's#^(trust_period[[:space:]]+=[[:space:]]+).*$#\1"'$TRUST_PERIOD'"#' $HOME/.${CONFIG_FOLDER}/config/config.toml

  # STATESYNC enabled
  sed -i.bak -E 's#^(enable[[:space:]]+=[[:space:]]+).*$#\1'true'#' $HOME/${CONFIG_FOLDER}/config/config.toml
}

start() {
  backup
  statesync
  echo -e "$YELLOW Restarting...$NORMAL"
  sudo systemctl restart ${SERVICE_NAME}
  echo -e "$YELLOW Checking logs...$NORMAL"
  sleep 3
  sudo journalctl -u ${SERVICE_NAME} -f --line 1000 | grep 'module=statesync'
}

start
