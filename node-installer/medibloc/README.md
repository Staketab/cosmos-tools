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

Specify version and GO path in this line `./install.sh -v GO_VERSION -p GO_PATH`  
Example `./install.sh -v 1.17.2 -p /root/go`  

### You can use all the variables or not use them at all and then the GO_VERSION and GO_PATH will be used by default as (-v 1.17.1 -p /usr/local/go)  

```
wget https://raw.githubusercontent.com/Staketab/node-tools/main/components/golang/install.sh \
&& chmod +x install.sh \
&& ./install.sh -v 1.17.2 -p /root/go \
&& rm -rf install.sh
```
Now apply the changes with the command below or reboot your terminal.  
```
. /etc/profile && . $HOME/.profile
```

### 2. Run Node setup:
Enter Enviroments `-g GIT_NAME -f GIT_FOLDER -b BIN_NAME -c CONFIG_FOLDER -v BIN_VER` and run this script to setup and build.  
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g GIT_NAME -f GIT_FOLDER -b BIN_NAME -c CONFIG_FOLDER -v BIN_VER
```
`GIT_NAME = medibloc`  
`GIT_FOLDER = panacea-core`  
`BIN_NAME = panacead`  
`CONFIG_FOLDER = panacea`  
`BIN_VER = v2.0.1`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g medibloc -f panacea-core -b panacead -c panacea -v v2.0.1
```

## 3. Data for start the chain. 
Chain-id - `panacea-3`  
Genesis file - [Link](https://github.com/medibloc/panacea-mainnet/raw/master/panacea-3/genesis.json.gz)  
Peers - `8c41cc8a6fc59f05138ae6c16a9eec05d601ef71@13.209.177.91:26656,cc0285c4d9cec8489f8bfed0a749dd8636406a0d@54.180.169.37:26656,1fc4a41660986ee22106445b67444ec094221e76@52.78.132.151:26656`  
Seed - `e93f5df69cc1b9bda230b3efcf162d4672293ded@3.35.82.40:26656,0e0db1c7ab1e37c76f2ceced0bb72e1c60ef17a6@13.124.96.254:26656,a83232db3a40e486b54b1463a43431e8490b808b@52.79.108.35:26656`  
minimum-gas-prices - `5umed`  

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart panacead.service`  
Cosmovisor service logs - `journalctl -u panacead.service -f`  
Stop Cosmovisor service - `systemctl stop panacead.service`  

## DONE
