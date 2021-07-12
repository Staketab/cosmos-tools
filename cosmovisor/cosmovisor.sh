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

COSMOVISOR=$1
GIT_NAME=$2
GIT_FOLDER=$3
BIN_NAME=$4
CONFIG_FOLDER=$5
BIN_VER=$6

set -u

function service {
sudo /bin/bash -c  'echo "[Unit]
Description='${BIN_NAME}' Node Service
After=network-online.target
[Service]
User=${USER}
Environment=DAEMON_NAME='${BIN_NAME}'
Environment=DAEMON_ALLOW_DOWNLOAD_BINARIES=true
Environment=DAEMON_RESTART_AFTER_UPGRADE=true
Environment=DAEMON_HOME='${HOME}'/.'${CONFIG_FOLDER}'
ExecStart='$(which cosmovisor)' start
Restart=always
RestartSec=3
LimitNOFILE=50000
[Install]
WantedBy=multi-user.target
" >/etc/systemd/system/'${BIN_NAME}'.service'

sudo systemctl daemon-reload && sudo systemctl enable ${BIN_NAME}.service

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Cosmovisor service installed.$NORMAL"
echo "-------------------------------------------------------------------"
}

function genesis {
echo -e "$GREEN Enter RAW link to Genesis file (Example: https://raw.githubusercontent.com/desmos-labs/morpheus/master/morpheus-apollo-1/genesis.json)$NORMAL"
read -p "Genesis link: " GENESIS
curl $GENESIS > ~/.${CONFIG_FOLDER}/config/genesis.json
}
function seeds {
echo -e "$GREEN Enter Seeds (Example: be3db0fe5ee7f764902dbcc75126a2e082cbf00c@seed-1.morpheus.desmos.network:26656)$NORMAL"
read -p "Seed: " SEED
sed -i.bak -E 's#^(seeds[[:space:]]+=[[:space:]]+).*$#\1"'$SEED'"#' ~/.${CONFIG_FOLDER}/config/config.toml
}
function peers {
echo -e "$GREEN Enter Peers (Validator or Sentry PEER) (Example: 728d59298dce64c72f13001f67a5b3e7fc080f91@135.181.201.2:26656)$NORMAL"
read -p "Persistent_peers: " PEERS
sed -i.bak -E 's#^(persistent_peers[[:space:]]+=[[:space:]]+).*$#\1"'$PEERS'"#' ~/.${CONFIG_FOLDER}/config/config.toml
}
function gas {
echo -e "$GREEN Enter minimum-gas-prices (Example: 0.025udaric)$NORMAL"
read -p "minimum-gas-prices: " GAS_PRICE
sed -i.bak -E 's#^(minimum-gas-prices[[:space:]]+=[[:space:]]+).*$#\1"'$GAS_PRICE'"#' ~/.${CONFIG_FOLDER}/config/app.toml
}
function fastsync {
echo -e "$GREEN Enter fastsync version (Example: v0, v1, v2)$NORMAL"
echo -e "$YELLOW v0 (default) - the legacy fast sync implementation$NORMAL"
echo -e "$YELLOW v1 - refactor of v0 version for better testability$NORMAL"
echo -e "$YELLOW v2 - complete redesign of v0, optimized for testability & readability$NORMAL"
read -p "version: " FASTSYNC
sed -i.bak -E 's#^(version[[:space:]]+=[[:space:]]+).*$#\1"'$FASTSYNC'"#' ~/.${CONFIG_FOLDER}/config/config.toml
}

function sentry {

echo -e "$YELLOW SENRTY CONFIGURING.$NORMAL"
echo -e "$YELLOW Next you need to provide CHAIN data.$NORMAL"
echo -e "$YELLOW If some data is not needed, just press ENTER to go next.$NORMAL"
echo "-------------------------------------------------------------------"

sleep 3

echo -e "$GREEN Enter CHAIN-ID$NORMAL"
read -p "Chain-id: " CHAIN

echo -e "$GREEN Enter your Sentry Moniker$NORMAL"
read -p "Moniker: " MONIKER
if [ "$CHAIN" == "" ]; then
    ${BIN_NAME} init $MONIKER
else
    ${BIN_NAME} init $MONIKER --chain-id $CHAIN
fi

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Your SENTRY Moniker: ${MONIKER}, initialised.$NORMAL"
echo -e "$YELLOW Your SENTRY NODE-ID: $NORMAL"
${BIN_NAME} tendermint show-node-id
echo "-------------------------------------------------------------------"

sleep 5

genesis
seeds
peers
gas
fastsync

sed -i.bak -E 's#^(pex[[:space:]]+=[[:space:]]+).*$#\1'true'#' ~/.${CONFIG_FOLDER}/config/config.toml
sed -i.bak -E 's#^(addr_book_strict[[:space:]]+=[[:space:]]+).*$#\1'false'#' ~/.${CONFIG_FOLDER}/config/config.toml

echo "-------------------------------------------------------------------"
echo -e "$YELLOW ${BIN_NAME} Configured and waiting to start.$NORMAL"
echo "-------------------------------------------------------------------"
echo -e "$YELLOW Installation of ${BIN_NAME}, and cosmovisor complete.$NORMAL"
echo "-------------------------------------------------------------------"
echo -e "$YELLOW Waiting for start the chain!$NORMAL"
echo "-------------------------------------------------------------------"
}

function validator {

echo -e "$YELLOW VALIDATOR CONFIGURING.$NORMAL"
echo -e "$YELLOW Next you need to provide CHAIN data.$NORMAL"
echo -e "$YELLOW If some data is not needed, just press ENTER to go next.$NORMAL"
echo "-------------------------------------------------------------------"

sleep 3

echo -e "$GREEN Enter CHAIN-ID$NORMAL"
read -p "Chain-id: " CHAIN

echo -e "$GREEN Enter your Moniker$NORMAL"
read -p "Moniker: " MONIKER
if [ "$CHAIN" == "" ]; then
    ${BIN_NAME} init $MONIKER
else
    ${BIN_NAME} init $MONIKER --chain-id $CHAIN
fi

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Your Validator Moniker: ${MONIKER}, initialised.$NORMAL"
echo -e "$YELLOW Your Validator NODE-ID: $NORMAL"
${BIN_NAME} tendermint show-node-id
echo "-------------------------------------------------------------------"

sleep 5

genesis
seeds
peers
gas
fastsync

sed -i.bak -E 's#^(pex[[:space:]]+=[[:space:]]+).*$#\1'false'#' ~/.${CONFIG_FOLDER}/config/config.toml

echo "-------------------------------------------------------------------"
echo -e "$YELLOW ${BIN_NAME} Configured and waiting to start.$NORMAL"
echo "-------------------------------------------------------------------"
echo -e "$YELLOW Installation of ${BIN_NAME}, and cosmovisor complete.$NORMAL"
echo "-------------------------------------------------------------------"
echo -e "$YELLOW Waiting for start the chain!$NORMAL"
echo "-------------------------------------------------------------------"
}

function configuring {

mkdir -p $GOBIN ${HOME}/.${CONFIG_FOLDER}/cosmovisor/genesis/bin ${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades/Gir/bin

mkdir -p $GOPATH/src/github.com/cosmos && cd $GOPATH/src/github.com/cosmos && git clone https://github.com/cosmos/cosmos-sdk && cd cosmos-sdk/cosmovisor && git checkout ${COSMOVISOR} && make cosmovisor

mv cosmovisor $GOBIN

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Cosmovisor built and installed.$NORMAL"
echo "-------------------------------------------------------------------"

mkdir $GOPATH/src/github.com/${GIT_FOLDER} && cd $GOPATH/src/github.com/${GIT_FOLDER} && git clone https://github.com/${GIT_NAME}/${GIT_FOLDER} && cd ${GIT_FOLDER} && git fetch && git checkout tags/${BIN_VER} && make install && make build

echo "-------------------------------------------------------------------"
echo -e "$YELLOW ${BIN_NAME} built and installed.$NORMAL"
echo "-------------------------------------------------------------------"

if [ -e $GOPATH/src/github.com/${GIT_FOLDER}/${GIT_FOLDER}/build/${BIN_NAME} ]; then
  cp build/${BIN_NAME} ${HOME}/.${CONFIG_FOLDER}/cosmovisor/genesis/bin
  cp build/${BIN_NAME} ${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades/Gir/bin
elif [ -e $GOBIN/${BIN_NAME} ]; then
  cd
  cp $GOBIN/${BIN_NAME} ${HOME}/.${CONFIG_FOLDER}/cosmovisor/genesis/bin
  cp $GOBIN/${BIN_NAME} ${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades/Gir/bin
else
  cp $(which ${BIN_NAME}) ${HOME}/.${CONFIG_FOLDER}/cosmovisor/genesis/bin
  cp $(which ${BIN_NAME}) ${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades/Gir/bin
fi

ln -s -T ${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades/Gir ${HOME}/.${CONFIG_FOLDER}/cosmovisor/current

cd
echo "export PATH=$HOME/.${CONFIG_FOLDER}/cosmovisor/current/bin:\$PATH" >> ~/.profile
echo "export BIN_NAME=${BIN_NAME}" >> ~/.profile
echo "export CONFIG_FOLDER=${CONFIG_FOLDER}" >> ~/.profile
echo "export DAEMON_NAME=${BIN_NAME}" >> ~/.profile
echo "export DAEMON_HOME=${HOME}/.${CONFIG_FOLDER}" >> ~/.profile
echo "export DAEMON_ALLOW_DOWNLOAD_BINARIES=true" >> ~/.profile
echo "export DAEMON_RESTART_AFTER_UPGRADE=true" >> ~/.profile
. ~/.profile

service
}

function initialising {

echo -e "$YELLOW Next, you need to choose which type of node to configure.$NORMAL"
echo -e "$YELLOW If you have to configure SENTRY node type$RED yes$NORMAL.$NORMAL"
echo -e "$YELLOW If you have to configure VALIDATOR node type$RED no$NORMAL.$NORMAL"
read -p "Your answer: " ANSWER
if [ "$ANSWER" == "yes" ]; then
    sentry
elif [ "$ANSWER" == "no" ]; then
    validator
else
    echo -e "$RED Answer wrong. Exited...$NORMAL"
    exit 0
fi

}

function start {
sleep 2

sudo systemctl start ${BIN_NAME}.service

journalctl -u ${BIN_NAME}.service -f
}

configuring
initialising
start
