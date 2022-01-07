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
`GIT_NAME = OmniFlix`  
`GIT_FOLDER = omniflixhub`  
`BIN_NAME = omniflixhubd`  
`CONFIG_FOLDER = omniflixhub`  
`BIN_VER = v0.3.0`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g OmniFlix -f omniflixhub -b omniflixhubd -c omniflixhub -v v0.3.0 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain.  
Binary link:
```
none
```
Chain-id:
```
flixnet-3
```  
Genesis file:
```
https://raw.githubusercontent.com/OmniFlix/testnets/main/flixnet-3/genesis.json
```
Peers:
```
f05968e78c84fd3997583fabeb3733a4861f53bf@45.72.100.120:26656,b29fad915c9bcaf866b0a8ad88493224118e8b78@104.154.172.193:26656,28ea934fbe330df2ca8f0ddd7a57a8a68c39a1a2@45.72.100.110:26656,94326ddc5661a1b571ea10c0626f6411f4926230@45.72.100.111:26656
```
Seed:
```
75a6d3a3b387947e272dab5b4647556e8a3f9fc1@45.72.100.122:26656
```
minimum-gas-prices:
```
0.001uflix
```

## 4. Service commands.
Reload configuration change - `sudo systemctl daemon-reload`  
Restart Cosmovisor service - `sudo systemctl restart omniflixhubd.service`  
Cosmovisor service logs - `sudo journalctl -u omniflixhubd.service -f`  
Stop Cosmovisor service - `sudo systemctl stop omniflixhubd.service`  

## DONE
