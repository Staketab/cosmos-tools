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
    COSMOVISOR_VER=${1:-"v1.0.0"}
    export COSMOVISOR_VER=${COSMOVISOR_VER}
}


function line {
    echo "-------------------------------------------------------------------"
}
function rlyService {
sudo /bin/bash -c  'echo "[Unit]
Description=Relayer Service
After=network-online.target
[Service]
Type=simple
User=$(whoami)
ExecStart='$(which rly)' start '${PORT}'
Restart=always
RestartSec=3
LimitNOFILE=57777
[Install]
WantedBy=multi-user.target
" >/etc/systemd/system/rly.service'

    sudo systemctl daemon-reload && sudo systemctl enable rly.service

    line
    echo -e "$GREEN Relayer service installed.$NORMAL"
    line
}

function rlyPacketsService {
sudo /bin/bash -c  'echo "[Unit]
Description=Relayer packets Service
After=network-online.target
[Service]
User=$(whoami)
ExecStart=/bin/bash /root/rly-pack.bash
Restart=always
RestartSec=3
LimitNOFILE=57777
[Install]
WantedBy=multi-user.target
" >/etc/systemd/system/rly-packets.service'

    sudo systemctl daemon-reload && sudo systemctl enable rly-packets.service

    line
    echo -e "$GREEN Relayer- service installed.$NORMAL"
    line
}
function source {

}
function installSource {

}
function launch {
    setup "${1}" "${2}" "${3}" "${4}" "${5}" "${6}"

}

while getopts ":g:f:b:c:v:cv:" o; do
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
    cv)
      cv=${OPTARG}
      ;;
  esac
done
shift $((OPTIND-1))

launch "${g}" "${f}" "${b}" "${c}" "${v}" "${cv}"
