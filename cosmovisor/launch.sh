#!/bin/bash

curl -s https://raw.githubusercontent.com/Staketab/node-tools/main/logo.sh | bash

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
NORMAL="\033[0m"

setup() {
    binarypath "${1}"
    binary "${2}"
    configfolder "${3}"
    cosmovisor_version "${4}"
}
binarypath() {
    BINARY_PATH=${1}
}
binary() {
    BIN_NAME=${1}
    export DAEMON_NAME="${BIN_NAME}"
}
configfolder() {
    CONFIG_FOLDER=${1}
    export DAEMON_HOME="${HOME}/.${CONFIG_FOLDER}"
}
cosmovisor_version() {
    COSMOVISOR_VER=${1:-"v1.3.0"}
    export COSMOVISOR_VER=${COSMOVISOR_VER}
}
line() {
    echo "-------------------------------------------------------------------"
}
cosmService() {
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
ExecStart='$(which cosmovisor)' run start '${FLAG}' --home '${HOME}'/.'${CONFIG_FOLDER}'
Restart=always
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
" >/etc/systemd/system/'${BIN_NAME}'.service'

    sudo systemctl daemon-reload && sudo systemctl enable ${BIN_NAME}.service

    echo -e "$GREEN:: Cosmovisor service installed.$NORMAL"
    line
}
cosmVars() {
    sudo /bin/bash -c  'echo "export PATH=$HOME/.'${CONFIG_FOLDER}'/cosmovisor/current/bin:\$PATH" >> $HOME/.profile'
    sudo /bin/bash -c  'echo "export BIN_NAME='${BIN_NAME}'" >> $HOME/.profile'
    sudo /bin/bash -c  'echo "export CONFIG_FOLDER='${CONFIG_FOLDER}'" >> $HOME/.profile'
    sudo /bin/bash -c  'echo "export DAEMON_NAME='${BIN_NAME}'" >> $HOME/.profile'
    sudo /bin/bash -c  'echo "export DAEMON_HOME=$HOME/.'${CONFIG_FOLDER}'" >> $HOME/.profile'
    sudo /bin/bash -c  'echo "export DAEMON_ALLOW_DOWNLOAD_BINARIES=true" >> $HOME/.profile'
    sudo /bin/bash -c  'echo "export DAEMON_RESTART_AFTER_UPGRADE=true" >> $HOME/.profile'
    sudo /bin/bash -c  'echo "export DAEMON_LOG_BUFFER_SIZE=512" >> $HOME/.profile'
    export DAEMON_NAME="${BIN_NAME}"
    export DAEMON_HOME="${HOME}/.${CONFIG_FOLDER}"
    . $HOME/.profile
}
versCosmovisor() {
    line
    echo -e "$GREEN CHOOSE COSMOSVISOR VERSION: $NORMAL"
    line
    echo -e "$RED 1$NORMAL -$YELLOW Cosmosvisor$NORMAL$RED v1.3.0 (Recommended)$NORMAL"
    echo -e "$RED 2$NORMAL -$YELLOW Cosmosvisor$NORMAL$RED v1.2.0$NORMAL"
    echo -e "$RED 3$NORMAL -$YELLOW Cosmosvisor$NORMAL$RED latest$NORMAL"
    line
    read -p "Answer: " COSM_VERSION
    if [ "$COSM_VERSION" == "1" ]; then
        go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v1.3.0
    elif [ "$COSM_VERSION" == "2" ]; then
        go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v1.2.0
    elif [ "$COSM_VERSION" == "3" ]; then
        go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@latest
    else
        go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/'cosmovisor@'${COSMOVISOR_VER}''
    fi
    line
    echo -e "$GREEN:: Cosmovisor installed...$NORMAL"
    line
}
initCosmovisor() {
    cosmVars
    NAME=$(echo ${BIN_NAME})
    PATHS=$(echo ${HOME}/.${CONFIG_FOLDER})
    if [ "$DAEMON_NAME" == "${NAME}" ] && [ "$DAEMON_HOME" == "${PATHS}" ]; then
        echo -e "$GREEN:: Checking vars:$NORMAL"
        line
        echo ${NAME}
        echo ${PATHS}
        line
        sleep 3
        cosmovisor init ${BINARY_PATH}
        line
        echo -e "$GREEN:: Cosmosvisor initialised successfully.$NORMAL"
    else
        line
        echo -e "$RED:: DAEMON_NAME and DAEMON_HOME vars not found...$NORMAL"
        line
    fi
}
compCosmovisor() {
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
    line
    read -p "Answer: " COSM_INSTALL_ANSWER
    if [ "$COSM_INSTALL_ANSWER" == "1" ]; then
        LS_CUR="${HOME}/.${CONFIG_FOLDER}/cosmovisor/current"
        UPGLS="${HOME}/.${CONFIG_FOLDER}/cosmovisor/upgrades"
        COSMBIN="$GOPATH/bin/cosmovisor"
        if [ -e $COSMBIN ]; then
            line
            echo -e "$YELLOW Cosmosvisor binary exists...$NORMAL"
            echo -e "$GREEN Choose option: $NORMAL"
            echo -e "$RED 1$NORMAL -$YELLOW Update binary$NORMAL"
            echo -e "$RED 2$NORMAL -$YELLOW Leave the current$NORMAL"
            line
            read -p "Answer: " COSM_ANSWER
                if [ "$COSM_ANSWER" == "1" ]; then
                    versCosmovisor
                    line
                    echo -e "$GREEN:: Cosmosvisor built and installed.$NORMAL"
                    line
                fi
        else
            line
            echo -e "$YELLOW:: Installing...$NORMAL"
            versCosmovisor
        fi
        initCosmovisor
        if [ -e ${LS_CUR} ]; then
            mkdir -p ${UPGLS}
            line
            echo -e "$GREEN:: Checking Cosmosvisor update dir...$NORMAL"
            line
            ls -la ${LS_CUR}
            line
            sleep 2
        fi
        cosmService
    else
    line
    echo -e "$RED:: Skipped Cosmosvisor setup...$NORMAL"
    line
    fi
}
launch() {
    setup "${1}" "${2}" "${3}" "${4}"
    compCosmovisor
}

while getopts ":p:b:c:s:" o; do
  case "${o}" in
    p)
      p=${OPTARG}
      ;;
    b)
      b=${OPTARG}
      ;;
    c)
      c=${OPTARG}
      ;;
    s)
      s=${OPTARG}
      ;;
  esac
done
shift $((OPTIND-1))

launch "${p}" "${b}" "${c}" "${s}"
