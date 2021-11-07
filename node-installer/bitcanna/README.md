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
`GIT_NAME = BitCannaGlobal`  
`GIT_FOLDER = bcna`  
`BIN_NAME = bcnad`  
`CONFIG_FOLDER = bcna`  
`BIN_VER = v1.1`

## The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g BitCannaGlobal -f bcna -b bcnad -c bcna -v v1.1 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain. 
Binary link:
```
https://github.com/BitCannaGlobal/bcna/releases/download/v1.1/bcnad
```
Chain-id:
```
bitcanna-1
```  
Genesis file:
```
https://raw.githubusercontent.com/BitCannaGlobal/bcna/main/genesis.json
```
Peers:
```
7d359339e0aa23d316ee3bff0dc03de88d26adcd@135.181.177.155:26656,aeb97fc0e16519cf127f97e2db856314df90b495@135.181.181.120:26656,312237a27c62e21e3ec5e2a075cba0035db3fb66@95.217.42.107:26656
```
Seed:
```
d6aa4c9f3ccecb0cc52109a95962b4618d69dd3f@seed1.bitcanna.io:26656,23671067d0fd40aec523290585c7d8e91034a771@seed2.bitcanna.io:26656
```
minimum-gas-prices:
```
0.001ubcna
```

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart bcnad.service`  
Cosmovisor service logs - `journalctl -u bcnad.service -f`  
Stop Cosmovisor service - `systemctl stop bcnad.service`  

## DONE
