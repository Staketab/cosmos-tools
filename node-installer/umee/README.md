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
&& ./go.sh -v 1.17.2 \
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
`BIN_VER = v0.5.0-rc2`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g umee-network -f umee -b umeed -c umee -v v0.5.0-rc2 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain. 
https://github.com/umee-network/umee/releases  
Binary link:
```
none
```
Chain-id:
```
umee-alpha-mainnet-2
```  
Genesis file:
```
https://raw.githubusercontent.com/umee-network/testnets/main/networks/umee-alpha-mainnet-2/genesis.json
```
Peers:
```
308fccc6b1eb545d26b1021a56d2468eaf352066@134.209.194.97:26656,542a99d76a3598c9739d54f93dc9efb6743c17f7@134.122.70.132:26656,0c81c3a9796d0edf2aefde0e31521475de81a57f@143.198.139.198:26656
```
Seed:
```
none
```
minimum-gas-prices:
```
0.025uumee
```

## 4. Service commands.
Reload configuration change - `sudo systemctl daemon-reload`  
Restart Cosmovisor service - `sudo systemctl restart umeed.service`  
Cosmovisor service logs - `sudo journalctl -u umeed.service -f`  
Stop Cosmovisor service - `sudo systemctl stop umeed.service`  

## DONE
