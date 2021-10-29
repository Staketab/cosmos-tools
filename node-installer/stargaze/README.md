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
`GIT_NAME = public-awesome`  
`GIT_FOLDER = stargaze`  
`BIN_NAME = starsd`  
`CONFIG_FOLDER = starsd`  
`BIN_VER = v1.0.0`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g public-awesome -f stargaze -b starsd -c starsd -v v1.0.0
```

## 3. Data for start the chain. 
https://github.com/public-awesome/stargaze/releases/tag/v1.0.0  
Binary link:
```
none
```
Chain-id:
```
stargaze-1
```  
Genesis file:
```
https://raw.githubusercontent.com/public-awesome/mainnet/main/stargaze-1/genesis.tar.gz
```
Peers:
```
1d73521c565b37a53038fc730bcd207a3db361b6@144.91.91.30:26656,524dd60331c56d198deabbb70238c2cc69119cca@161.97.122.216:36656,0c9ebd7b36f96d0279dbf6dc38572f5797c096c1@65.108.42.168:26656,320e4b81ab327dd2593a39de0d3ae718fdb9347c@176.9.168.220:26656
```
Seed:
```
70ed826888f102c7c1ceb4d07287956628a53508@174.138.124.7:36656,722079345d941cd2da3daedea548c909d9b83ec5@104.248.101.113:36656,d5fc4f479c4e212c96dff5704bb2468ea03b8ae3@sg-seed.blockpane.com:26656
```
minimum-gas-prices:
```
0ustars
```

## 4. Service commands.
Reload configuration change - `sudo systemctl daemon-reload`  
Restart Cosmovisor service - `sudo systemctl restart starsd.service`  
Cosmovisor service logs - `sudo journalctl -u starsd.service -f`  
Stop Cosmovisor service - `sudo systemctl stop starsd.service`  

## DONE
