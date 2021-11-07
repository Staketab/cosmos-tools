# Auto-node-installer
Cosmos SDK multi-network automation script for node setup.  
### Features:  
- Node installer
- Cosmovisor installer
- Snapshots
- State-sync
- No need to edit config

### 1. Install GOLANG:
Install custom version of Golang #GO.  
Or you can install GO from [official website](https://golang.org/doc/install).  

Specify version and GO path in this line `./go.sh -v GO_VERSION -p GO_PATH`  
Example `./go.sh -v 1.17.2 -p /root/go`  

### You can use all the variables or not use them at all and then the GO_VERSION and GO_PATH will be used by default as (-v 1.17.1 -p /usr/local/go)  

```
wget https://raw.githubusercontent.com/Staketab/node-tools/main/components/golang/go.sh \
&& chmod +x go.sh \
&& ./go.sh -v 1.17.2 -p /root/go \
&& rm -rf go.sh
```
Now apply the changes with the command below or reboot your terminal.  
```
. /etc/profile && . $HOME/.bashrc
```

### 2. Run Node setup:
Enter Enviroments `-g GIT_NAME -f GIT_FOLDER -b BIN_NAME -c CONFIG_FOLDER -v BIN_VER` and run this script to setup and build.  
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g GIT_NAME -f GIT_FOLDER -b BIN_NAME -c CONFIG_FOLDER -v BIN_VER
```
`GIT_NAME = OmniFlix`  
`GIT_FOLDER = omniflixhub`  
`BIN_NAME = omniflixhubd`  
`CONFIG_FOLDER = omniflixhub`  
`BIN_VER = v0.2.1`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g OmniFlix -f omniflixhub -b omniflixhubd -c omniflixhub -v v0.2.1 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain.  
Binary link:
```
https://github.com/OmniFlix/omniflixhub/releases/download/v0.2.1/omniflixhubd
```
Chain-id:
```
flixnet-2
```  
Genesis file:
```
https://raw.githubusercontent.com/OmniFlix/testnets/main/flixnet-2/genesis.json
```
Peers:
```
65e362590690cedcddf5c7f4fc1b67c9d7b04fb2@45.72.100.118:26656,368a9a2b5096de253aaae302ff15a0a77fe06416@45.72.100.119:26656,cf8a7600b3daf23e9a3ce67ebe50c4af44701aa8@45.72.100.123:26656,93433a8c325d5ed5d2484d7fd23cda3dac511392@45.72.100.124:26656
```
Seed:
```
cdd6f704a2ecb6b9e53a9b753c894c95976e5cbe@45.72.100.121:26656,b0679b09bb72dfc29c332b5ea754cd578d106a49@45.72.100.122:26656
```
minimum-gas-prices:
```
0.001uflix
```

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart omniflixhubd.service`  
Cosmovisor service logs - `journalctl -u omniflixhubd.service -f`  
Stop Cosmovisor service - `systemctl stop omniflixhubd.service`  

## DONE
