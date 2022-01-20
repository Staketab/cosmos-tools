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
Example `./go.sh -v 1.17.2`  

### You can use all the variables or not use them at all and then the GO_VERSION and GO_PATH will be used by default as (-v 1.17.1 -p /usr/local/go)  

```
wget https://raw.githubusercontent.com/Staketab/node-tools/main/components/golang/go.sh \
&& chmod +x go.sh && ./go.sh -v 1.17.2 \
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
`GIT_NAME = cosmos-gaminghub`  
`GIT_FOLDER = nibiru`  
`BIN_NAME = nibirud`  
`CONFIG_FOLDER = nibiru`  
`BIN_VER = v0.9`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g cosmos-gaminghub -f nibiru -b nibirud -c nibiru -v v0.9 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain.  
Binary link:
```
https://github.com/cosmos-gaminghub/nibiru/releases/download/v0.9/nibirud-v0.9
```
Chain-id:
```
nibiru-3000
```  
Genesis file:
```
https://raw.githubusercontent.com/cosmos-gaminghub/testnets/master/nibiru-3000/genesis.json
```
Peers:
```
none
```
Seed:
```
4d6c590024b3a24985e910b172fc3b7d3493648a@45.32.39.253:26656
```
minimum-gas-prices:
```
0.001ugame
```

## 4. Service commands.
Reload configuration change - `sudo systemctl daemon-reload`  
Restart Cosmovisor service - `sudo systemctl restart nibirud.service`  
Cosmovisor service logs - `sudo journalctl -u nibirud.service -f`  
Stop Cosmovisor service - `sudo systemctl stop nibirud.service`  

## DONE
