#!/bin/bash

curl -s https://raw.githubusercontent.com/Staketab/node-tools/main/logo.sh | bash

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
NORMAL="\033[0m"

function setup {
    gitname "${1}"
    gitfolder "${2}"
    binary "${3}"
    configfolder "${4}"
    binary_version "${5}"
    cosmovisor_version "${6}"
}

function gitname {
    GIT_NAME=${1}
}

function gitfolder {
    GIT_FOLDER=${1}
}

function binary {
    BIN_NAME=${1}
}

function configfolder {
    CONFIG_FOLDER=${1}
}

function binary_version {
    BIN_VER=${1}
}
function cosmovisor_version {
    COSMOVISOR_VER=${1:-"v0.1.0"}
    export COSMOVISOR_VER=${COSMOVISOR_VER}
}


function line {
    echo "-------------------------------------------------------------------"
}
function binService {
sudo /bin/bash -c  'echo "[Unit]
Description='${BIN_NAME}' Node Service
After=network-online.target
[Service]
Type=simple
User=$(whoami)
ExecStart='$(which ${BIN_NAME})' start --home '${HOME}'/.'${CONFIG_FOLDER}'
Restart=always
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
" >/etc/systemd/system/'${BIN_NAME}'.service'

    sudo systemctl daemon-reload && sudo systemctl enable ${BIN_NAME}.service

    line
    echo -e "$GREEN ${BIN_NAME} service installed.$NORMAL"
    line
}
function cosmService {
sudo /bin/bash -c  'echo "[Unit]
Description='${BIN_NAME}' Node Service
After=network-online.target
[Service]
User=$(whoami)
Environment=DAEMON_NAME='${BIN_NAME}'
Environment=DAEMON_ALLOW_DOWNLOAD_BINARIES=true
Environment=DAEMON_RESTART_AFTER_UPGRADE=true
Environment=DAEMON_LOG_BUFFER_SIZE=512
Environment=UNSAFE_SKIP_BACKUP=true
Environment=DAEMON_HOME='${HOME}'/.'${CONFIG_FOLDER}'
ExecStart='$(which cosmovisor)' start --home '${HOME}'/.'${CONFIG_FOLDER}'
Restart=always
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
" >/etc/systemd/system/'${BIN_NAME}'.service'

    sudo systemctl daemon-reload && sudo systemctl enable ${BIN_NAME}.service

    line
    echo -e "$GREEN Cosmovisor service installed.$NORMAL"
    line
}
function source {
    mkdir -p ${GOPATH}/src{,/github.com}
    cd $GOPATH/src/github.com \
    && git clone https://github.com/${GIT_NAME}/${GIT_FOLDER} \
    && cd ${GIT_FOLDER} \
    && git fetch \
    && git checkout tags/${BIN_VER} \
    && make install
    if [ -f ${GOPATH}/bin/${BIN_NAME} ]; then
        echo -e "$GREEN ${BIN_NAME} found. Continue...$NORMAL"
    else
        make build
        BUILD="$GOPATH/src/github.com/${GIT_FOLDER}/build"
        if [ -f ${GOPATH}/bin/${BIN_NAME} ]; then
            echo -e "$GREEN ${BIN_NAME} found. Continue...$NORMAL"
        elif [ -f $BUILD/${BIN_NAME} ]; then
            cp $BUILD/${BIN_NAME} ${GOPATH}/bin/
            echo -e "$GREEN ${BIN_NAME} found. Continue...$NORMAL"
        else
            make all
        fi
    fi
    line
    echo -e "$GREEN ${BIN_NAME} built and installed.$NORMAL"
    line
}
function installSource {
    PROJECT="$GOPATH/src/github.com/${GIT_FOLDER}"
    if [ -e $PROJECT ]; then
        line
        echo -e "$YELLOW ${GIT_FOLDER} folder exists...$NORMAL"
        echo -e "$RED 1$NORMAL -$YELLOW Reinstall ${GIT_FOLDER}.$NORMAL"
        echo -e "$RED 2$NORMAL -$YELLOW Do nothing.$NORMAL"
        line
        read -p "Your answer: " ANSWER
        if [ "$ANSWER" == "1" ]; then
            rm -rf $PROJECT
            source
        elif [ "$ANSWER" == "2" ]; then
            line
            echo -e "$YELLOW The option to do nothing is selected. Continue...$NORMAL"
            line
        fi
    else
        source
    fi
}
function installBinary {
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
    elif [ -f $BINARY*.gz ]; then
        echo -e "$YELLOW :: Unpacking archive with BINARY...$NORMAL"
        gunzip -c $HOME/tmp/*.gz
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

    if [ -f $BINARY${BIN_NAME} ]; then
        echo -e "$YELLOW :: BINARY file correct...$NORMAL"
    elif [ $BINARY* != ${BIN_NAME} ]; then
        echo -e "$YELLOW :: Renaming BINARY...$NORMAL"
        mv $BINARY* $BINARY
    fi

    cp $BINARY$BIN_NAME $GOPATH/bin
    sudo chmod +x $GOPATH/bin/$BIN_NAME
    cd
    rm -rf $HOME/tmp
}
function bin_config {
    line
    echo -e "$GREEN INSTALLATION OPTIONS.$NORMAL"
    line
    echo -e "$YELLOW Select installation method:$NORMAL"
    echo -e "$RED 1$NORMAL -$YELLOW Install from SOURCE.$NORMAL"
    echo -e "$RED 2$NORMAL -$YELLOW Install using BINARY.$NORMAL"
    read -p "Your answer: " ANSWERS
    if [ "$ANSWERS" == "1" ]; then
        installSource
    elif [ "$ANSWERS" == "2" ]; then
        installBinary
    else
        echo -e "$RED Wrong answeer. Try again...$NORMAL"
        exit 0
    fi
}
function checkAria {
    ARIA2C=$(which aria2c)
        if [ -f "$ARIA2C" ]; then
            line
            echo -e "$YELLOW File ARIA2C exist. No need to install.$NORMAL"
            line
        else
            line
            echo -e "$YELLOW Installing ARIA2C tool to fast downloading.$NORMAL"
            installAria
            line
            echo -e "$GREEN ARIA2C installed.$NORMAL"
            line
        fi
}
function installAria {
    sudo apt-get update -y -qq > /dev/null
    sudo apt-get install -y aria2 -qq > /dev/null
}
function genesis {
    echo -e "$GREEN Enter link to Genesis file (Example: https://raw.githubusercontent.com/desmos-labs/morpheus/master/morpheus-apollo-1/genesis.json)$NORMAL"
    read -p "Genesis link: " LINK2
    mkdir -p $HOME/tmp && cd $HOME/tmp
    GENESIS_PATH="$HOME/.${CONFIG_FOLDER}/config/"
    FILE="genesis.json"
    
    echo -e "$YELLOW :: Downloading file with Genesis...$NORMAL"
    GENESIS=$HOME/tmp/
    wget -P $GENESIS $LINK2 --quiet --show-progress
    if [ -f $GENESIS*.zip ]; then
        echo -e "$YELLOW :: Unpacking archive with Genesis...$NORMAL"
        unzip -q $HOME/tmp/*.zip
    elif [ -f $GENESIS*.tar.gz ]; then
        echo -e "$YELLOW :: Unpacking archive with Genesis...$NORMAL"
        tar -xzvf $HOME/tmp/*.tar.gz -C $GENESIS
    elif [ -f $GENESIS*.gz ]; then
        echo -e "$YELLOW :: Unpacking archive with Genesis...$NORMAL"
        gunzip -c $HOME/tmp/*.gz > $FILE
    elif [ -f $GENESIS*.bzip2 ]; then
        echo -e "$YELLOW :: Unpacking archive with Genesis...$NORMAL"
        tar -xvjf $HOME/tmp/*.bzip2 -C $GENESIS
    elif [ -f $GENESIS*.gzip ]; then
        echo -e "$YELLOW :: Unpacking archive with Genesis...$NORMAL"
        tar -xvzf $HOME/tmp/*.gzip -C $GENESIS
    elif [ -f $GENESIS*.tar ]; then
        echo -e "$YELLOW :: Unpacking archive with Genesis...$NORMAL"
        tar -xvjf $HOME/tmp/*.tar -C $GENESIS
    elif [ -f $GENESIS*.json ]; then
        echo -e "$YELLOW It's not archive. Continue...$NORMAL"
    fi

    if [ -f $GENESIS$FILE ]; then
        echo -e "$YELLOW :: Genesis file correct...$NORMAL"
        mv $HOME/tmp/*.json $GENESIS_PATH$FILE
    elif [ $GENESIS*.json != $FILE ]; then
        echo -e "$YELLOW :: Renaming Genesis...$NORMAL"
        mv $HOME/tmp/*.json $GENESIS_PATH$FILE
    fi
    cd
    rm -rf $HOME/tmp

    line
    echo -e "$GREEN Checking genesis SHASUM -a 256:$NORMAL"
    shasum -a 256 $HOME/.${CONFIG_FOLDER}/config/genesis.json
    line
    sleep 3
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
function snapshot {
    sleep 2
    SNAP="$(curl -s https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/snapshot.sh | grep SNAP_BINARIES)"
    if [[ $SNAP == *"${CHAIN}"* ]]; then
        line
        echo -e "$GREEN FOUND A SNAPSHOT FOR THE$NORMAL$RED ${BIN_NAME}$NORMAL$GREEN NETWORK WITH CHAIN-ID:$NORMAL$RED ${CHAIN}$NORMAL"
        line
        echo -e "$GREEN CHOOSE OPTION: $NORMAL"
        echo -e "$RED 1$NORMAL -$YELLOW Use Snapshot$NORMAL"
        echo -e "$RED 2$NORMAL -$YELLOW Don't use Snapshot$NORMAL"
        read -p "Answer: " SNAP_ANSWER
        if [ "$SNAP_ANSWER" == "1" ]; then
            curl -s https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/snapshot.sh | bash
        else
            statesync
        fi
    else
        statesync
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
    #SERVERIP="$(curl ifconfig.me)"
    line
    echo -e "$GREEN Enter RPC Servers 1 (Example: rpc1.com:26657)$NORMAL"
    read -p "RPC Server 1: " RPC_STATE_1
    echo -e "$GREEN Enter RPC Server 2 (Example: rpc1.com:26657)$NORMAL"
    read -p "RPC Server 2: " RPC_STATE_2
    line
    LATEST_HEIGHT=$(curl -s $RPC_STATE_1/block | jq -r .result.block.header.height)
    TRUST_HEIGHT=$((LATEST_HEIGHT - 2000))
    TRUST_HASH=$(curl -s "$RPC_STATE_1/block?height=$TRUST_HEIGHT" | jq -r .result.block_id.hash)
    echo -e "$YELLOW RPC SERVERS:$NORMAL$RED ${RPC_STATE_1},${RPC_STATE_2}$NORMAL"
    echo -e "$YELLOW TRUST_HEIGHT:$NORMAL$RED ${TRUST_HEIGHT}$NORMAL"
    echo -e "$YELLOW TRUST_HASH:$NORMAL$RED ${TRUST_HASH}$NORMAL"
    line
    sleep 3

    #sed -i.bak -E 's#^(external_address[[:space:]]+=[[:space:]]+).*$#\1"'$SERVERIP':26656"#' $HOME/.${CONFIG_FOLDER}/config/config.toml
    sed -i.bak -E 's#^(rpc_servers[[:space:]]+=[[:space:]]+).*$#\1"'$RPC_STATE_1','$RPC_STATE_2'"#' $HOME/.${CONFIG_FOLDER}/config/config.toml
    sed -i.bak -E 's#^(trust_height[[:space:]]+=[[:space:]]+).*$#\1"'$TRUST_HEIGHT'"#' $HOME/.${CONFIG_FOLDER}/config/config.toml
    sed -i.bak -E 's#^(trust_hash[[:space:]]+=[[:space:]]+).*$#\1"'$TRUST_HASH'"#' $HOME/.${CONFIG_FOLDER}/config/config.toml
    #sed -i.bak -E 's#^(trust_period[[:space:]]+=[[:space:]]+).*$#\1"'$TRUST_PERIOD'"#' $HOME/.${CONFIG_FOLDER}/config/config.toml

    # STATESYNC enabled
    sed -i.bak -E 's#^(enable[[:space:]]+=[[:space:]]+).*$#\1'true'#' $HOME/.${CONFIG_FOLDER}/config/config.toml
}
function cosmVars {
    sudo /bin/bash -c  'echo "export PATH=$HOME/.'${CONFIG_FOLDER}'/cosmovisor/current/bin:\$PATH" >> $HOME/.profile'
    sudo /bin/bash -c  'echo "export BIN_NAME='${BIN_NAME}'" >> $HOME/.profile'
    sudo /bin/bash -c  'echo "export CONFIG_FOLDER='${CONFIG_FOLDER}'" >> $HOME/.profile'
    sudo /bin/bash -c  'echo "export DAEMON_NAME='${BIN_NAME}'" >> $HOME/.profile'
    sudo /bin/bash -c  'echo "export DAEMON_HOME=${HOME}/.'${CONFIG_FOLDER}'" >> $HOME/.profile'
    sudo /bin/bash -c  'echo "export DAEMON_ALLOW_DOWNLOAD_BINARIES=true" >> $HOME/.profile'
    sudo /bin/bash -c  'echo "export DAEMON_RESTART_AFTER_UPGRADE=true" >> $HOME/.profile'
    sudo /bin/bash -c  'echo "export DAEMON_LOG_BUFFER_SIZE=512" >> $HOME/.profile'
    . $HOME/.profile
}
function compCosmovisor {
    line
    echo -e "$GREEN COSMOSVISOR SETUP: $NORMAL"
    line
    echo -e "$YELLOW Cosmosvisor is a small process manager for Cosmos SDK application binaries that$NORMAL"
    echo -e "$YELLOW monitors the governance module for incoming chain upgrade proposals. If it sees a$NORMAL"
    echo -e "$YELLOW proposal that gets approved, Cosmosvisor can automatically download the new$NORMAL"
    echo -e "$YELLOW binary, stop the current binary, switch from the old binary to the new one, and$NORMAL"
    echo -e "$YELLOW finally restart the node with the new binary.$NORMAL"
    echo -e "$YELLOW Source:$NORMAL$RED https://docs.cosmos.network/master/run-node/cosmovisor.html#cosmosvisor$NORMAL"
    line
    echo -e "$GREEN CHOOSE OPTION. $NORMAL"
    echo -e "$RED 1$NORMAL -$YELLOW Install Cosmosvisor$NORMAL"
    echo -e "$RED 2$NORMAL -$YELLOW Don't install Cosmosvisor$NORMAL"
    read -p "Answer: " COSM_INSTALL_ANSWER
    if [ "$COSM_INSTALL_ANSWER" == "1" ]; then
        LS_CUR="${HOME}/.${CONFIG_FOLDER}/cosmovisor/current"
        GENBIN="${HOME}/.${CONFIG_FOLDER}/cosmovisor/genesis/bin"
        UPGBIN="${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades/Gir/bin"
        UPGLS="${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades/Gir"
        COSMBIN="$GOPATH/bin/cosmovisor"
        if [ -e $COSMBIN ]; then
            mkdir -p ${GENBIN} ${UPGBIN}
            line
            echo -e "$YELLOW Cosmosvisor binary exists...$NORMAL"
            echo -e "$GREEN Choose option: $NORMAL"
            echo -e "$RED 1$NORMAL -$YELLOW Update binary$NORMAL"
            echo -e "$RED 2$NORMAL -$YELLOW Leave the current$NORMAL"
            read -p "Answer: " COSM_ANSWER
                if [ "$COSM_ANSWER" == "1" ]; then
                    #go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v0.1.0
                    go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/'cosmovisor@'${COSMOVISOR_VER}''
                    line
                    echo -e "$GREEN Cosmosvisor built and installed.$NORMAL"
                    line
                fi
        else
            mkdir -p ${GENBIN} ${UPGBIN}
            #go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v0.1.0
            go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/'cosmovisor@'${COSMOVISOR_VER}''
            line
            echo -e "$GREEN Cosmosvisor built and installed.$NORMAL"
            line
        fi
        if [ -e ${LS_CUR} ]; then
            rm -rf ${LS_CUR}
            ln -s -T ${UPGLS} ${LS_CUR}
            line
            echo -e "$GREEN Checking Cosmosvisor update dir...$NORMAL"
            ls -la ${LS_CUR}
            line
            sleep 2
        else
            ln -s -T ${UPGLS} ${LS_CUR}
            line
            echo -e "$GREEN Checking Cosmosvisor update dir...$NORMAL"
            ls -la ${LS_CUR}
            line
            sleep 2
        fi
        BUILD="$GOPATH/src/github.com/${GIT_FOLDER}/build"
        if [ -e $BUILD/${BIN_NAME} ]; then
            cp $BUILD/${BIN_NAME} ${GENBIN}
            cp $BUILD/${BIN_NAME} ${UPGBIN}
        elif [ -e $GOPATH/bin/${BIN_NAME} ]; then
            cd
            cp $GOPATH/bin/${BIN_NAME} ${GENBIN}
            cp $GOPATH/bin/${BIN_NAME} ${UPGBIN}
        else
            cp $(which ${BIN_NAME}) ${GENBIN}
            cp $(which ${BIN_NAME}) ${UPGBIN}
        fi
        chmod +x ${GENBIN}/*
        chmod +x ${UPGBIN}/*

        cosmService
        cosmVars
        line
        echo -e "$GREEN Setup of Cosmosvisor complete.$NORMAL"
        line
    else
    line
    echo -e "$RED Skipped Cosmosvisor setup...$NORMAL"
    line
    fi
}
function launch {
    setup "${1}" "${2}" "${3}" "${4}" "${5}" "${6}"

    bin_config
    binService
    echo -e "$GREEN VALIDATOR NODE CONFIGURING.$NORMAL"
    echo -e "$YELLOW Next you need to provide CHAIN data.$NORMAL"
    echo -e "$YELLOW If some data is not needed, just press ENTER to go next.$NORMAL"
    line
    sleep 3
    echo -e "$GREEN Enter CHAIN-ID$NORMAL"
    read -p "Chain-id: " CHAIN
    export CHAIN=${CHAIN}
    export CONFIG_FOLDER=${CONFIG_FOLDER}
    line
    echo -e "$GREEN Enter your Moniker$NORMAL"
    read -p "Moniker: " MONIKER
    GENESIS_FILE="$HOME/.${CONFIG_FOLDER}/config/genesis.json"
    CONFIG_HOME="$HOME/.${CONFIG_FOLDER}"
        if [ "$CHAIN" == "" ]; then
            rm -rf ${GENESIS_FILE}
            ${BIN_NAME} init $MONIKER --home $CONFIG_HOME
        else
            rm -rf ${GENESIS_FILE}
            ${BIN_NAME} init $MONIKER --chain-id $CHAIN --home $CONFIG_HOME
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
    peers
    seeds
    gas
    snapshot
    compCosmovisor

    line
    echo -e "$GREEN ${BIN_NAME} Configured.$NORMAL"
    line
    echo -e "$GREEN Now you can start the chain!$NORMAL"
    line
    echo -e "$YELLOW Use$NORMAL$RED sudo systemctl start ${BIN_NAME}.service && sudo journalctl -u ${BIN_NAME}.service -f$NORMAL"
    line
    echo -e "$GREEN DONE$NORMAL"
    line
}

while getopts ":g:f:b:c:v:s:" o; do
  case "${o}" in
    g)
      g=${OPTARG}
      ;;
    f)
      f=${OPTARG}
      ;;
    b)
      b=${OPTARG}
      ;;
    c)
      c=${OPTARG}
      ;;
    v)
      v=${OPTARG}
      ;;
    s)
      s=${OPTARG}
      ;;
  esac
done
shift $((OPTIND-1))

launch "${g}" "${f}" "${b}" "${c}" "${v}" "${s}"
