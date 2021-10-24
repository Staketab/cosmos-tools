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
`GIT_NAME = umee-network`  
`GIT_FOLDER = umee`  
`BIN_NAME = umeed`  
`CONFIG_FOLDER = umee`  
`BIN_VER = v0.2.1`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g umee-network -f umee -b umeed -c umee -v v0.2.1
```

## 3. Data for start the chain. 
https://github.com/umee-network/umee/releases  
Binary link:
```
https://github.com/umee-network/umee/releases/download/v0.2.1/umeed-v0.2.1-linux-amd64.tar.gz
```
Chain-id:
```
umeevengers-1с
```  
Genesis file:
```
https://raw.githubusercontent.com/umee-network/testnets/main/networks/umeevengers-1c/genesis.json
```
Peers:
```
1694e2cd89b03270577e547d7d84ebef13e4eff1@172.105.168.226:26656,4d50abb293f399a0f41ef9dbebe62615d4c85e42@3.34.147.65:26656,d2447c2ba201fb5bdd7250921c7c267af18c0950@94.130.23.149:26656,901a625ecf43014cc383239524c5eb6595a56888@135.181.165.110:26656,4ea1dc6af45f0fad7315029d181ada53f7d3174c@161.97.182.71:26656,60a11b328f161fe8f3f98f85e838addb07513c9e@46.101.234.47:26656,03c8165065c925f3bf56be6d2b5aa820c5f8e26c@194.163.166.56:26656,4bf9ff17d148418aec04fdda9bff671e482457a3@213.202.252.173:26656,1fb83420fd2bf665dc886fb3727d809579d63e51@206.189.133.102:26656,b85598b96a9c8e835b7b2f2c0b322eb2317fe7cd@94.250.201.70:26656
```
Seed:
```
none
```
minimum-gas-prices:
```
none
```

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart umeed.service`  
Cosmovisor service logs - `journalctl -u umeed.service -f`  
Stop Cosmovisor service - `systemctl stop umeed.service`  

## DONE
