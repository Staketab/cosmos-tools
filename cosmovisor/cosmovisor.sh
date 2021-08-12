#!/bin/bash

curl -s https://raw.githubusercontent.com/Staketab/node-tools/main/logo.sh | bash

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

# set -u
# reverted if
if [ "$COSMOVISOR" == "" ]; then
    exit
fi
if [ "$GIT_NAME" == "" ]; then
    exit
fi
if [ "$GIT_FOLDER" == "" ]; then
    exit
fi
if [ "$BIN_NAME" == "" ]; then
    exit
fi
if [ "$CONFIG_FOLDER" == "" ]; then
    exit
fi
if [ "$BIN_VER" == "" ]; then
    exit
fi

function line {
echo "-------------------------------------------------------------------"
}
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

line
echo -e "$GREEN Cosmovisor service installed.$NORMAL"
line
}
function source {
PROJECT="$GOPATH/src/github.com/${GIT_FOLDER}"
if [ -e $PROJECT ]; then
    echo -e "$YELLOW ${GIT_FOLDER} folder exists...$NORMAL"
else
    cd $GOPATH/src/github.com && git clone https://github.com/${GIT_NAME}/${GIT_FOLDER} && cd ${GIT_FOLDER} && git fetch && git checkout tags/${BIN_VER} && make install && make build
    line
    echo -e "$GREEN ${BIN_NAME} built and installed.$NORMAL"
    line
fi
}
function binary {
line
echo -e "$GREEN Insers link to the BINARY file or archive (Example: https://github.com/desmos-labs/desmos/releases/download/v0.17.5/desmos-amd64.zip)$NORMAL"
read -p "Link: " LINK
mkdir -p $HOME/tmp && cd $HOME/tmp
echo -e "$YELLOW :: Downloading archive with BINARY...$NORMAL"
wget --quiet --show-progress $LINK
BINARY=$HOME/tmp/
if [ -f $BINARY*.zip ]; then
    echo -e "$YELLOW :: Unpacking archive with BINARY...$NORMAL"
    unzip $HOME/tmp/*.zip
elif [ -f $BINARY*.tar.gz ]; then
    echo -e "$YELLOW :: Unpacking archive with BINARY...$NORMAL"
    tar -xzvf $HOME/tmp/*.tar.gz
elif [ -f $BINARY*.bzip2 ]; then
    echo -e "$YELLOW :: Unpacking archive with BINARY...$NORMAL"
    tar -xvjf $HOME/tmp/*.bzip2
elif [ -f $BINARY*.gzip ]; then
    echo -e "$YELLOW :: Unpacking archive with BINARY...$NORMAL"
    tar -xvzf $HOME/tmp/*.gzip
elif [ -f $BINARY*.tar ]; then
    echo -e "$YELLOW :: Unpacking archive with BINARY...$NORMAL"
    tar -xvjf $HOME/tmp/*.tar
elif [ -f $BINARY* ]; then
    echo -e "$YELLOW It's not archive. Continue...$NORMAL"
fi
cp $HOME/tmp/$BIN_NAME $GOBIN
rm -rf $HOME/tmp
}
function bin_config {
line
echo -e "$GREEN INSTALLATION OPTIONS.$NORMAL"
line
echo -e "$YELLOW Select installation method:$NORMAL"
#echo -e "$RED 1$NORMAL -$YELLOW Install from SOURCE.$NORMAL"
#echo -e "$RED 2$NORMAL -$YELLOW Install using BINARY.$NORMAL"
echo ""
var=("Install from SOURCE" "Install using BINARY")
select opt in "${var[@]}"
do
    case $opt in
        "Install from SOURCE")
            echo -e "$YELLOW Install from SOURCE.$NORMAL"
            source
			break
            ;;
        "Install using BINARY")
            echo -e "$YELLOW Install using BINARY.$NORMAL"
            binary
			break
            ;;
        *) echo -e "$RED Wrong answer. Try again...$NORMAL";;
    esac
done

#read -p "Your answer: " ANSWERS

#if [ "$ANSWERS" == "1" ]; then
#    source
#elif [ "$ANSWERS" == "2" ]; then
#    binary
#else
#    echo -e "$RED Wrong answeer. Try again...$NORMAL"
#    exit 0
#fi
}
function genesis {
echo -e "$GREEN Enter RAW link to Genesis file (Example: https://raw.githubusercontent.com/desmos-labs/morpheus/master/morpheus-apollo-1/genesis.json)$NORMAL"
read -p "Genesis link: " GENESIS
curl $GENESIS > $HOME/.${CONFIG_FOLDER}/config/genesis.json
}
function seeds {
line
echo -e "$GREEN Enter Seeds (Example: be3db0fe5ee7f764902dbcc75126a2e082cbf00c@seed-1.morpheus.desmos.network:26656)$NORMAL"
read -p "Seed: " SEED
sed -i.bak -E 's#^(seeds[[:space:]]+=[[:space:]]+).*$#\1"'$SEED'"#' $HOME/.${CONFIG_FOLDER}/config/config.toml
}
function peers {
line
echo -e "$GREEN Enter Peers (Validator or Sentry PEER) (Example: 728d59298dce64c72f13001f67a5b3e7fc080f91@135.181.201.2:26656)$NORMAL"
read -p "Persistent_peers: " PEERS
sed -i.bak -E 's#^(persistent_peers[[:space:]]+=[[:space:]]+).*$#\1"'$PEERS'"#' $HOME/.${CONFIG_FOLDER}/config/config.toml
}
function gas {
line
echo -e "$GREEN Enter minimum-gas-prices (Example: 0.025udaric)$NORMAL"
read -p "minimum-gas-prices: " GAS_PRICE
sed -i.bak -E 's#^(minimum-gas-prices[[:space:]]+=[[:space:]]+).*$#\1"'$GAS_PRICE'"#' $HOME/.${CONFIG_FOLDER}/config/app.toml
}
function fastsync {
line
echo -e "$GREEN ENTER FASTSYNC VERSION (Example: 1, 2, 3)$NORMAL"
line
echo -e "$RED 1$NORMAL -$YELLOW v0 (default) - the legacy fast sync implementation$NORMAL"
echo -e "$RED 2$NORMAL -$YELLOW v1 - refactor of v0 version for better testability$NORMAL"
echo -e "$RED 3$NORMAL -$YELLOW v2 - complete redesign of v0, optimized for testability & readability$NORMAL"
read -p "version: " FASTSYNC
if [ "$FASTSYNC" == "1" ]; then
    sed -i.bak -E 's#^(version[[:space:]]+=[[:space:]]+).*$#\1"'v0'"#' $HOME/.${CONFIG_FOLDER}/config/config.toml
elif [ "$FASTSYNC" == "2" ]; then
    sed -i.bak -E 's#^(version[[:space:]]+=[[:space:]]+).*$#\1"'v1'"#' $HOME/.${CONFIG_FOLDER}/config/config.toml
elif [ "$FASTSYNC" == "3" ]; then
    sed -i.bak -E 's#^(version[[:space:]]+=[[:space:]]+).*$#\1"'v2'"#' $HOME/.${CONFIG_FOLDER}/config/config.toml
else
    sed -i.bak -E 's#^(version[[:space:]]+=[[:space:]]+).*$#\1"'v0'"#' $HOME/.${CONFIG_FOLDER}/config/config.toml
fi
}
function statesync {
line
echo -e "$GREEN STATE SYNC CONFIGURATION OPTIONS.$NORMAL"
line
echo -e "$YELLOW State sync rapidly bootstraps a new node by discovering,$NORMAL"
echo -e "$YELLOW fetching, and restoring a state machine snapshot from peers$NORMAL"
echo -e "$YELLOW instead of fetching and replaying historical blocks.$NORMAL"
line
echo -e "$GREEN CHOOSE OPTION.$NORMAL"
line
echo -e "$RED 1$NORMAL -$YELLOW If you want to configure STATESYNC.$NORMAL"
echo -e "$RED 2$NORMAL -$YELLOW If you don't want to configure STATESYNC.$NORMAL"
read -p "Your answer: " ANSWERS
if [ "$ANSWERS" == "1" ]; then
    statesync-c
elif [ "$ANSWERS" == "2" ]; then
    echo -e "$YELLOW The STATESYNC setting is skipped. Сontinue...$NORMAL"
else
    echo -e "$YELLOW The STATESYNC setting is skipped. Сontinue...$NORMAL"
fi
}
function statesync-c {
line
echo -e "$GREEN Enter RPC Servers (Example: rpc1.com:26657,rpc1.com:26657)$NORMAL"
read -p "RPC Servers: " RPC_STATE
line
echo -e "$GREEN Enter Trust Height (Example: 1580047)$NORMAL"
read -p "Trust Height: " TRUST_HEIGHT
line
echo -e "$GREEN Enter Trust Hash (Example: 6FD28DAAAC79B77F589AE692B6CD403412CE27D0D2629E81951607B297696E5B)$NORMAL"
read -p "Trust Hash: " TRUST_HASH
line
echo -e "$GREEN Enter Trust Period - 2/3 of unbonding time (Example: 168h0m0s)$NORMAL"
read -p "Trust Period: " TRUST_PERIOD
line

sed -i.bak -E 's#^(rpc_servers[[:space:]]+=[[:space:]]+).*$#\1"'$RPC_STATE'"#' $HOME/.${CONFIG_FOLDER}/config/config.toml
sed -i.bak -E 's#^(trust_height[[:space:]]+=[[:space:]]+).*$#\1"'$TRUST_HEIGHT'"#' $HOME/.${CONFIG_FOLDER}/config/config.toml
sed -i.bak -E 's#^(trust_hash[[:space:]]+=[[:space:]]+).*$#\1"'$TRUST_HASH'"#' $HOME/.${CONFIG_FOLDER}/config/config.toml
sed -i.bak -E 's#^(trust_period[[:space:]]+=[[:space:]]+).*$#\1"'$TRUST_PERIOD'"#' $HOME/.${CONFIG_FOLDER}/config/config.toml

# STATESYNC enabled
sed -i.bak -E 's#^(enable[[:space:]]+=[[:space:]]+).*$#\1'true'#' $HOME/.${CONFIG_FOLDER}/config/config.toml
}

function sentry {

echo -e "$YELLOW SENRTY CONFIGURING.$NORMAL"
echo -e "$YELLOW Next you need to provide CHAIN data.$NORMAL"
echo -e "$YELLOW If some data is not needed, just press ENTER to go next.$NORMAL"
line

sleep 3

line
echo -e "$GREEN Enter CHAIN-ID$NORMAL"
read -p "Chain-id: " CHAIN

line
echo -e "$GREEN Enter your Sentry Moniker$NORMAL"
read -p "Moniker: " MONIKER
if [ "$CHAIN" == "" ]; then
    ${BIN_NAME} init $MONIKER
else
    ${BIN_NAME} init $MONIKER --chain-id $CHAIN
fi

line
echo -e "$YELLOW Your SENTRY Moniker: $NORMAL$GREEN${MONIKER}$NORMAL$YELLOW, initialised.$NORMAL"
echo -e "$YELLOW Your SENTRY NODE-ID: $NORMAL"
${BIN_NAME} tendermint show-node-id
line
echo -e "$YELLOW Your full PEER: $NORMAL"
echo $(${BIN_NAME} tendermint show-node-id)'@'$(curl -s ifconfig.me)':'$(cat $HOME/.${CONFIG_FOLDER}/config/config.toml | sed -n '/Address to listen for incoming connection/{n;p;}' | sed 's/.*://; s/".*//')
line

sleep 5

genesis
seeds
peers
gas
echo -e "$YELLOW Waiting...$NORMAL"
sleep 3
statesync
fastsync

sed -i.bak -E 's#^(pex[[:space:]]+=[[:space:]]+).*$#\1'true'#' $HOME/.${CONFIG_FOLDER}/config/config.toml
sed -i.bak -E 's#^(addr_book_strict[[:space:]]+=[[:space:]]+).*$#\1'false'#' $HOME/.${CONFIG_FOLDER}/config/config.toml

line
echo -e "$GREEN ${BIN_NAME} Configured and waiting to start.$NORMAL"
line
echo -e "$GREEN Installation of ${BIN_NAME}, and cosmovisor complete.$NORMAL"
line
echo -e "$GREEN Waiting for start the chain!$NORMAL"
line
}

function validator {

echo -e "$YELLOW VALIDATOR CONFIGURING.$NORMAL"
echo -e "$YELLOW Next you need to provide CHAIN data.$NORMAL"
echo -e "$YELLOW If some data is not needed, just press ENTER to go next.$NORMAL"
line

sleep 3

line
echo -e "$GREEN Enter CHAIN-ID$NORMAL"
read -p "Chain-id: " CHAIN

line
echo -e "$GREEN Enter your Moniker$NORMAL"
read -p "Moniker: " MONIKER
if [ "$CHAIN" == "" ]; then
    ${BIN_NAME} init $MONIKER
else
    ${BIN_NAME} init $MONIKER --chain-id $CHAIN
fi

line
echo -e "$YELLOW Your Validator Moniker: $NORMAL$GREEN${MONIKER}$NORMAL$YELLOW, initialised.$NORMAL"
echo -e "$YELLOW Your Validator NODE-ID: $NORMAL"
${BIN_NAME} tendermint show-node-id
line
echo -e "$YELLOW Your full PEER: $NORMAL"
echo $(${BIN_NAME} tendermint show-node-id)'@'$(curl -s ifconfig.me)':'$(cat $HOME/.${CONFIG_FOLDER}/config/config.toml | sed -n '/Address to listen for incoming connection/{n;p;}' | sed 's/.*://; s/".*//')
line

sleep 5

genesis
seeds
peers
gas
echo -e "$YELLOW Waiting...$NORMAL"
sleep 3
statesync
fastsync

sed -i.bak -E 's#^(pex[[:space:]]+=[[:space:]]+).*$#\1'false'#' $HOME/.${CONFIG_FOLDER}/config/config.toml

line
echo -e "$GREEN ${BIN_NAME} Configured and waiting to start.$NORMAL"
line
echo -e "$GREEN Installation of ${BIN_NAME}, and cosmovisor complete.$NORMAL"
line
echo -e "$GREEN Waiting for start the chain!$NORMAL"
line
}

function configuring {

SDK="$GOPATH/src/github.com/cosmos-sdk"
if [ -e $SDK ]; then
    mkdir -p ${HOME}/.${CONFIG_FOLDER}/cosmovisor/genesis/bin ${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades/Gir/bin
    echo -e "$YELLOW Cosmos SDK folder exists...$NORMAL"
else
    mkdir -p ${HOME}/.${CONFIG_FOLDER}/cosmovisor/genesis/bin ${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades/Gir/bin
    mkdir -p $GOPATH/src/github.com && cd $GOPATH/src/github.com && git clone https://github.com/cosmos/cosmos-sdk && cd cosmos-sdk/cosmovisor && git checkout ${COSMOVISOR} && make cosmovisor
    cp cosmovisor $GOBIN
    line
    echo -e "$GREEN Cosmovisor built and installed.$NORMAL"
    line
fi

bin_config

if [ -e ${HOME}/.${CONFIG_FOLDER}/cosmovisor/current ]; then
    rm -rf ${HOME}/.${CONFIG_FOLDER}/cosmovisor/current
    ln -s -T ${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades/Gir ${HOME}/.${CONFIG_FOLDER}/cosmovisor/current
else
    ln -s -T ${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades/Gir ${HOME}/.${CONFIG_FOLDER}/cosmovisor/current
fi

BUILD="$GOPATH/src/github.com/${GIT_FOLDER}/build"
if [ -e $BUILD/${BIN_NAME} ]; then
    cp $BUILD/${BIN_NAME} ${HOME}/.${CONFIG_FOLDER}/cosmovisor/genesis/bin
    cp $BUILD/${BIN_NAME} ${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades/Gir/bin
elif [ -e $GOBIN/${BIN_NAME} ]; then
    cd
    cp $GOBIN/${BIN_NAME} ${HOME}/.${CONFIG_FOLDER}/cosmovisor/genesis/bin
    cp $GOBIN/${BIN_NAME} ${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades/Gir/bin
else
    cp $(which ${BIN_NAME}) ${HOME}/.${CONFIG_FOLDER}/cosmovisor/genesis/bin
    cp $(which ${BIN_NAME}) ${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades/Gir/bin
fi
chmod +x ${HOME}/.${CONFIG_FOLDER}/cosmovisor/genesis/bin/*
chmod +x ${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades/Gir/bin/*

cd
echo "export PATH=$HOME/.${CONFIG_FOLDER}/cosmovisor/current/bin:\$PATH" >> $HOME/.profile
echo "export BIN_NAME=${BIN_NAME}" >> $HOME/.profile
echo "export CONFIG_FOLDER=${CONFIG_FOLDER}" >> $HOME/.profile
echo "export DAEMON_NAME=${BIN_NAME}" >> $HOME/.profile
echo "export DAEMON_HOME=${HOME}/.${CONFIG_FOLDER}" >> $HOME/.profile
echo "export DAEMON_ALLOW_DOWNLOAD_BINARIES=true" >> $HOME/.profile
echo "export DAEMON_RESTART_AFTER_UPGRADE=true" >> $HOME/.profile
. $HOME/.profile

service
}

function initialising {

echo -e "$GREEN Next, you need to choose which type of node to configure.$NORMAL"
echo -e "$RED 1$NORMAL -$YELLOW VALIDATOR node.$NORMAL"
echo -e "$RED 2$NORMAL -$YELLOW SENTRY node.$NORMAL"
read -p "Your answer: " ANSWER
if [ "$ANSWER" == "1" ]; then
    validator
elif [ "$ANSWER" == "2" ]; then
    sentry
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
