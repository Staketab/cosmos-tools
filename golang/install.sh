#!/bin/bash
VERSION=$1

if [ "$VERSION" == "" ]; then
    VERSION="1.15.6"
fi
OS=`uname -s`
# HOME_DIR=$HOME
# GO_HOME=$HOME_DIR/go
GO_ROOT=/usr/local/go
ARCH=`uname -m`

function usage {
    printf "./go.sh -v <version> \n"
    printf "Example: ./go.sh -v 1.11.5 \n"
    exit 1
}

while getopts ":v:" opt; do
  case $opt in
    v) VERSION="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    echo 
    usage
    ;;
  esac
done 

function preparation {
    echo "-----------------------------------------"
    echo "               System Update             "
    echo "-----------------------------------------"
    sudo apt update && sudo apt upgrade -y
    echo "-----------------------------------------"
    echo "                 Packages                "
    echo "-----------------------------------------"
    sudo apt-get install build-essential ocaml ocamlbuild automake autoconf libtool wget python libssl-dev git cmake perl tmux ufw gcc unzip zip jq make -y
    sudo apt-get install golang-statik -y
}

function scan {
echo "-----------------------------------------"
echo "   Scan if an old version was installed   "
echo "-----------------------------------------"
if [ -d /usr/local/go ]
then 
    echo "An older version was installed."
    read -p "Would you like to remove it? [y/n]: " ans
    case "$ans" in 
        "y"|"yes"|"Y"|"Yes"|"YES") sudo rm -rf /usr/local/go
        echo "Old version successfully removed."
        ;;
        *) echo "Exiting..."
           exit 0
        ;;
    esac
fi
echo "No old version was found. Proceed."
}

function install {
    echo "-----------------------------------------"
    echo "              Install Golang             "
    echo "-----------------------------------------"
    if ! test -d $HOME/Downloads
    then
        mkdir -p $HOME/Downloads
    fi
    #cd $HOME/Downloads

    # 64-bit Linux
    if [ "$OS" == "Linux" ] && [ "$ARCH" == "x86_64" ]
    then
        PACKAGE=go$VERSION.linux-amd64.tar.gz
        pushd ~/go #> /dev/null
            echo "-----------------------------------------"
            echo "                Downloading              "
            echo "-----------------------------------------"
            wget https://dl.google.com/go/$PACKAGE
            if [ $? -ne 0 ]; then 
                echo "Failed to download !!!"
                exit 1
            fi
            echo "-----------------------------------------"
            echo "              Extract Package            "
            echo "-----------------------------------------"
            sudo tar -C /usr/local -xzf $PACKAGE
            rm -rf $PACKAGE
        popd #> /dev/null
        cd ~
        permission
        setup
        success
        exit 0
    fi
}

function permission {
    echo "-----------------------------------------"
    echo "              Set Permissions            "
    echo "-----------------------------------------"
    sudo chown root:root /usr/local/go
    sudo chmod 755 /usr/local/go
    echo "Permissions set !"
}

function setup {
    echo "-----------------------------------------"
    echo "             Set Go Workspace            "
    echo "-----------------------------------------"
    echo "Where would you like your Go Workspace folder to be? (example: /home)"
    read -p "Path: " GO_WS_PATH
    cd $GO_WS_PATH
    read -p "Give the folder a name: " GO_WS_NAME
    GO_PATH=$PWD/$GO_WS_NAME
    echo "Your Go Workspace folder has been set to $GO_PATH"
    mkdir -p $GO_WS_NAME{,/bin,/pkg,/src}
    cd ~
    echo "-----------------------------------------"
    echo "             Set Env Variables           "
    echo "-----------------------------------------"
    sudo sh -c "echo 'export PATH=\$PATH:/usr/local/go/bin' >> /etc/profile"
    echo "export GOPATH=$GO_PATH" >> ~/.bashrc
    echo "export PATH=$GO_PATH/bin:\$PATH" >> ~/.bashrc
    echo "export GOBIN=/root/go/bin" >> ~/.bashrc
    source ~/.bashrc
    echo "Setup done !"
}

function success {
    echo "-----------------------------------------"
    echo "                 Success                 "
    echo "-----------------------------------------"
    echo "Go $VERSION has been successfully installed.
    Reboot the system to take effects."
}

preparation
scan
install
permission
setup