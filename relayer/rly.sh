#!/bin/bash

curl -s https://raw.githubusercontent.com/Staketab/node-tools/main/logo.sh | bash

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
NORMAL="\033[0m"

function setup {
  port "${1}"
  rly_version "${2}"
}
function port {
  PORT=${1:-"transfer"}
}
function rly_version {
  RLY_VER=${1:-"v1.0.0"}
  export RLY_VER=${RLY_VER}
}
function rly_dir {
  RELAYER_DIR="$HOME/.relayer-${PORT}"
}
function line {
  echo "-------------------------------------------------------------------"
}
function goCheck {
  if ! [ -x "$(command -v go)" ]; then
    goSetup
  else
    goVars
    line
    echo -e "$GREEN GO installed.$NORMAL"
    line
  fi
}
function goSetup {
  wget https://raw.githubusercontent.com/Staketab/node-tools/main/components/golang/go.sh \
  && sudo bash +x ./go.sh -v 1.17.2 \
  && rm -rf go.sh \
  && . /etc/profile && . $HOME/.bashrc
  goVars
}
function goVars {
  export GOPATH=$HOME/go
  export PATH=$HOME/go/bin:$PATH
  export GOBIN=$HOME/go/bin
  export GOROOT=/usr/local/go
  export GO111MODULE=on
}
function rlyCheck {
  if ! [ -x "$(command -v rly)" ]; then
    rlySetup
  else
    line
    echo -e "$GREEN Relayer installed. Continue...$NORMAL"
    line
  fi
}
function rlySetup {
  mkdir -p ${GOPATH}/src{,/github.com}
  cd $GOPATH/src/github.com \
  && git clone https://github.com/cosmos/relayer.git \
  && cd relayer \
  && git fetch \
  && git checkout tags/${RLY_VER} \
  && make install
  if [ -f ${GOPATH}/bin/rly ]; then
    echo -e "$GREEN Relayer found. Continue...$NORMAL"
  else
    echo -e "$GREEN Relayer not found. Exit...$NORMAL"
    exit 1
  fi
  line
  echo -e "$GREEN Relayer installed.$NORMAL"
  line
}
function varChains {
  echo -e "$GREEN Let's start configuring chains.$NORMAL"
  line
  echo -e "$YELLOW Enter Chain ID 1:(Example: cosmoshub-4)$NORMAL"
  line
  read -p "CHAIN ID 1: " CHAIN_1
  line
  echo -e "$YELLOW Enter Chain ID 2:(Example: osmosis-1)$NORMAL"
  line
  read -p "CHAIN ID 2: " CHAIN_2
  line
  echo -e "$YELLOW Enter Key name 1:(Example: rly_key_1)$NORMAL"
  line
  read -p "KEY NAME 1: " KEY_1
  line
  echo -e "$YELLOW Enter Key name 2:(Example: rly_key_2)$NORMAL"
  line
  read -p "KEY NAME 2: " KEY_2
  line
  echo -e "$YELLOW Enter RPC addres for CHAIN 1:(Example: 127.0.0.1:26657)$NORMAL"
  line
  read -p "RPC 1: " RPC_1
  line
  echo -e "$YELLOW Enter RPC addres for CHAIN 2:(Example: 127.0.0.1:36657)$NORMAL"
  line
  read -p "RPC 2: " RPC_2
  line
  echo -e "$YELLOW Enter account-prefix for CHAIN 1:(Example: cosmos)$NORMAL"
  line
  read -p "PREFIX 1: " PREFIX_1
  line
  echo -e "$YELLOW Enter account-prefix for CHAIN 2:(Example: osmo)$NORMAL"
  line
  read -p "PREFIX 2: " PREFIX_2
  line
  echo -e "$YELLOW Enter gas-price for CHAIN 1:(Example: 0.001uatom)$NORMAL"
  line
  read -p "GAS_PRICE 1: " GAS_PRICE_1
  line
  echo -e "$YELLOW Enter gas-price for CHAIN 2:(Example: 0.001uosmo)$NORMAL"
  line
  read -p "GAS_PRICE 2: " GAS_PRICE_2
  line
  echo -e "$YELLOW Default: 2/3 of the unbonding period for Cosmos SDK chains.$NORMAL"
  echo -e "$YELLOW Example: unbonding period = 3 weeks, trusting period = 2 weeks$NORMAL"
  line
  echo -e "$YELLOW Enter trusting-period for CHAIN 1:(Example: 10h)$NORMAL"
  line
  read -p "TRUST_PERIOD 1: " TRUST_PERIOD_1
  line
  echo -e "$YELLOW Enter trusting-period for CHAIN 2:(Example: 10h)$NORMAL"
  line
  read -p "TRUST_PERIOD 2: " TRUST_PERIOD_2
  line
  echo -e "$YELLOW Enter mnemonic phrase for KEY 1 CHAIN 1:(Example: peanut solar proof hidden perfect dust funny stand sphere stomach ignore gauge knock trigger tree art spell nuclear grape suggest discover inside seed)$NORMAL"
  line
  read -p "MNEMONIC_1: " MNEMONIC_1
  line
  echo -e "$YELLOW Enter mnemonic phrase for KEY 2 CHAIN 2:(Example: peanut solar proof hidden perfect dust funny stand sphere stomach ignore gauge knock trigger tree art spell nuclear grape suggest discover inside seed)$NORMAL"
  line
  read -p "MNEMONIC_2: " MNEMONIC_2
}
function rlyInitConfig {
  rly config init --home $RELAYER_DIR
}
function rlyAddChainsPaths {
  rly config add-chains $RELAYER_DIR/chains --home $RELAYER_DIR
  rly config add-paths $RELAYER_DIR/paths --home $RELAYER_DIR
}
function rlyRestoreKeys {
  rly keys restore ${CHAIN_1} ${KEY_1} "$MNEMONIC_1" --home $RELAYER_DIR
  rly keys restore ${CHAIN_2} ${KEY_2} "$MNEMONIC_2" --home $RELAYER_DIR
}
function rlyLink {
  rly tx link ${PORT} --home $RELAYER_DIR
  echo -e "$YELLOW transfer completed$NORMAL"
}
function rlyService {
sudo /bin/bash -c  'echo "[Unit]
Description=Relayer Service
After=network-online.target
[Service]
Type=simple
User=$(whoami)
ExecStart='$(which rly)' start '${PORT}' --home '${RELAYER_DIR}'
Restart=always
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
" >/etc/systemd/system/rly-'${PORT}'.service'

  sudo systemctl daemon-reload && sudo systemctl enable rly-${PORT}.service

  line
  echo -e "$GREEN Relayer service installed.$NORMAL"
  line
}
function rlyPacketsService {
  wget -O ${RELAYER_DIR}/rly-pack.bash https://raw.githubusercontent.com/Staketab/cosmos-tools/rly/relayer/rly-pack.bash

sudo /bin/bash -c  'echo "[Unit]
Description=Relayer packets Service
After=network-online.target
[Service]
User=$(whoami)
ExecStart=/bin/bash +x '${RELAYER_DIR}'/rly-pack.bash
Restart=always
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
" >/etc/systemd/system/rly-packets-'${PORT}'.service'

  sudo systemctl daemon-reload && sudo systemctl enable rly-packets-${PORT}.service

  line
  echo -e "$GREEN Relayer-package service installed.$NORMAL"
  line
}
function chainsSetup {
  mkdir -p ${RELAYER_DIR}/chains
  sudo /bin/bash -c  'echo "{
      \"key\": \"'${KEY_1}'\",
      \"chain-id\": \"'${CHAIN_1}'\",
      \"rpc-addr\": \"http://'${RPC_1}'\",
      \"account-prefix\": \"'${PREFIX_1}'\",
      \"gas-prices\": \"'${GAS_PRICE_1}'\",
      \"gas-adjustment\": 1.5,
      \"trusting-period\": \"'${TRUST_PERIOD_1}'\"
  }
  " > '$RELAYER_DIR'/chains/'${CHAIN_1}'.json'

  sudo /bin/bash -c  'echo "{
      \"key\": \"'${KEY_2}'\",
      \"chain-id\": \"'${CHAIN_2}'\",
      \"rpc-addr\": \"http://'${RPC_2}'\",
      \"account-prefix\": \"'${PREFIX_2}'\",
      \"gas-prices\": \"'${GAS_PRICE_2}'\",
      \"gas-adjustment\": 1.5,
      \"trusting-period\": \"'${TRUST_PERIOD_2}'\"
  }
  " > '$RELAYER_DIR'/chains/'${CHAIN_2}'.json'
  line
  echo -e "$GREEN Chains ${CHAIN_1} ${CHAIN_2} created.$NORMAL"
  line
}
function pathsSetup {
  mkdir -p $RELAYER_DIR/paths
  sudo /bin/bash -c  'echo "{
      \"src\": {
      \"chain-id\": \"'${CHAIN_1}'\",
      \"client-id\": \"\",
      \"connection-id\": \"\",
      \"channel-id\": \"\",
      \"port-id\": \"'${PORT}'\",
      \"order\": \"unordered\",
      \"version\": \"ics20-1\"
    },
    \"dst\": {
      \"chain-id\": \"'${CHAIN_2}'\",
      \"client-id\": \"\",
      \"connection-id\": \"\",
      \"channel-id\": \"\",
      \"port-id\": \"'${PORT}'\",
      \"order\": \"unordered\",
      \"version\": \"ics20-1\"
    },
    \"strategy\": {
      \"type\": \"naive\"
    }
  }
  " > '$RELAYER_DIR'/paths/'${PORT}'.json'

  line
  echo -e "$GREEN Paths created.$NORMAL"
  line
}
function rlyServices {
RLY="/etc/systemd/system/rly-${PORT}.service"
if [ -f "$RLY" ]; then
    line
    echo -e "$YELLOW Found an rly service. Choose an option:$NORMAL"
    echo -e "$RED 1$NORMAL -$YELLOW Reinstall rly service.$NORMAL"
    echo -e "$RED 2$NORMAL -$YELLOW Do nothing.$NORMAL"
    line
    read -p "Your answer: " ANSWER
    if [ "$ANSWER" == "1" ]; then
        rm -rf $RLY
        rlyService
    elif [ "$ANSWER" == "2" ]; then
        line
        echo -e "$YELLOW The option to do nothing is selected. Continue...$NORMAL"
        line
    fi
else
    rlyService
    line
    echo -e "$GREEN rly service created.$NORMAL"
    line
fi

RLY_PACK="/etc/systemd/system/rly-packets-${PORT}.service"
if [ -f "$RLY_PACK" ]; then
    line
    echo -e "$YELLOW Found an rly-packets service. Choose an option:$NORMAL"
    echo -e "$RED 1$NORMAL -$YELLOW Reinstall rly-packets.$NORMAL"
    echo -e "$RED 2$NORMAL -$YELLOW Do nothing.$NORMAL"
    line
    read -p "Your answer: " ANSWERS
    if [ "$ANSWERS" == "1" ]; then
        rm -rf $RLY_PACK
        rlyPacketsService
    elif [ "$ANSWERS" == "2" ]; then
        line
        echo -e "$YELLOW The option to do nothing is selected. Continue...$NORMAL"
        line
    fi
else
    rlyPacketsService
    line
    echo -e "$GREEN rly-packets service created.$NORMAL"
    line
fi
}
function rlyRestart {
  sudo systemctl restart rly-${PORT}.service
  sudo systemctl restart rly-packets-${PORT}.service
}
function log {
  line
  echo -e "$GREEN sudo journalctl -u rly-${PORT} -f && sudo journalctl -u rly-packets-${PORT} -f$NORMAL"
  line
}
function launch {
  setup "${1}" "${2}"
  
  rly_dir
  goCheck
  rlyCheck
  varChains
  rlyInitConfig
  chainsSetup
  pathsSetup
  rlyAddChainsPaths
  rlyRestoreKeys
  rlyLink
  rlyServices
  rlyRestart
}
while getopts ":p:v:" o; do
  case "${o}" in
    p)
      p=${OPTARG}
      ;;
    v)
      v=${OPTARG}
      ;;
  esac
done
shift $((OPTIND-1))

launch "${p}" "${v}"
log
