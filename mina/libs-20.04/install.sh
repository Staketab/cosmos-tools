#!/bin/bash

echo "░██████╗████████╗░█████╗░██╗░░██╗███████╗████████╗░█████╗░██████╗░░░░░█████╗░░█████╗░███╗░░░███╗"
echo "██╔════╝╚══██╔══╝██╔══██╗██║░██╔╝██╔════╝╚══██╔══╝██╔══██╗██╔══██╗░░░██╔══██╗██╔══██╗████╗░████║"
echo "╚█████╗░░░░██║░░░███████║█████═╝░█████╗░░░░░██║░░░███████║██████╦╝░░░██║░░╚═╝██║░░██║██╔████╔██║"
echo "░╚═══██╗░░░██║░░░██╔══██║██╔═██╗░██╔══╝░░░░░██║░░░██╔══██║██╔══██╗░░░██║░░██╗██║░░██║██║╚██╔╝██║"
echo "██████╔╝░░░██║░░░██║░░██║██║░╚██╗███████╗░░░██║░░░██║░░██║██████╦╝██╗╚█████╔╝╚█████╔╝██║░╚═╝░██║"
echo "╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝╚═════╝░╚═╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝"
echo ""

sleep 1

YELLOW="\033[33m"
GREEN="\033[32m"

echo "---------------"
echo -e "$YELLOW Downloading libraries.\033[0m"
echo "---------------"
echo
cd
mkdir libs
cd libs 
wget http://mirrors.kernel.org/ubuntu/pool/main/libf/libffi/libffi6_3.2.1-8_amd64.deb
wget http://mirrors.edge.kernel.org/ubuntu/pool/universe/j/jemalloc/libjemalloc1_3.6.0-11_amd64.deb
wget http://mirrors.edge.kernel.org/ubuntu/pool/main/p/procps/libprocps6_3.3.12-3ubuntu1_amd64.deb

echo "---------------"
echo -e "$YELLOW Installing libraries.\033[0m"
echo "---------------"

sudo dpkg -i *.deb
cd

echo "---------------"
echo -e "$YELLOW Deleting all packages.\033[0m"
echo "---------------"

rm -rf libs

sleep 2

echo "---------------"
echo -e "$GREEN Libraries successfully installed.\033[0m"
echo "---------------"