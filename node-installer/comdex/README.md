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
`GIT_NAME = comdex-official`  
`GIT_FOLDER = comdex`  
`BIN_NAME = comdex`  
`CONFIG_FOLDER = comdex`  
`BIN_VER = v0.0.2`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g comdex-official -f comdex -b comdex -c comdex -v v0.0.2 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain. 
https://github.com/comdex-official/comdex/releases  
Binary link:
```
none
```
Chain-id:
```
comets-test
```  
Genesis file:
```
https://raw.githubusercontent.com/comdex-official/networks/main/testnet/comets-test/genesis_final.json
```
Peers:
```
3659590cd1466671a49421089e55f1392e1cad0e@15.207.189.210:26656,8b1ccf5cf3a3ba65ee074f46ea8c6c164d867104@52.201.166.91:26656,5307ce50bd8a6f7bb5a922e3f7109b5f3241c425@13.51.118.56:26656,9c25a7ab94a315f683c3693e17aec6b2c91c851c@52.77.115.73:26656
```
Seed:
```
none
```
minimum-gas-prices:
```
0.2ucmdx
```

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart comdex.service`  
Cosmovisor service logs - `journalctl -u comdex.service -f`  
Stop Cosmovisor service - `systemctl stop comdex.service`  

## DONE
