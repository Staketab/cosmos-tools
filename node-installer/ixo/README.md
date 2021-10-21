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
`GIT_NAME = ixofoundation`  
`GIT_FOLDER = ixo-blockchain`  
`BIN_NAME = ixod`  
`CONFIG_FOLDER = ixod`  
`BIN_VER = v1.6.0`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g ixofoundation -f ixo-blockchain -b ixod -c ixod -v v1.6.0
```

## 3. Data for start the chain. 
https://github.com/ixofoundation/ixo-blockchain/releases/tag/v1.6.0  
Binary link:
```
none
```
Chain-id:
```
impacthub-3
```  
Genesis file:
```
https://raw.githubusercontent.com/ixofoundation/genesis/master/impacthub-3/genesis.json
```
Peers:
```
34a26a4cb5d2f1a5051a7057af9cc5b313258130@206.81.5.133:26656,c48aa4ac28d33f874f1884e04e2e60ce7f724709@176.9.80.46:36656,cbe8c6a5a77f861db8edb1426b734f2cf1fa4020@18.166.133.210:26656,36e4738c7efcf353d3048e5e6073406d045bae9d@80.64.208.42:26656,f0d4546fa5e0c2d84a4244def186b9da3c12ba1a@46.166.138.214:26656,c95af93f0386f8e19e65997262c9f874d1901dc5@18.163.242.188:26656
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
Restart Cosmovisor service - `systemctl restart ixod.service`  
Cosmovisor service logs - `journalctl -u ixod.service -f`  
Stop Cosmovisor service - `systemctl stop ixod.service`  

## DONE
