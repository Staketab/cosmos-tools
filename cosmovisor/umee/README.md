# AUTOVISOR
Tebdermint multi-network automation script for Cosmovisor + node setup - UMEE TESTNET.

## 1. Install GOLANG.
Install custom version of Golang #GO. 
Specify version in this line `./install.sh -v VERSION`
Example `./install.sh -v 1.17.1`

Or you can install GO from [official website](https://golang.org/doc/install).
```
wget https://raw.githubusercontent.com/Staketab/node-tools/main/components/golang/install.sh \
&& chmod +x install.sh \
&& ./install.sh -v 1.17.1
```
Reboot your terminal after installing.

## 2. Run COSMOVISOR setup and build.
Enter Enviroments on the example of the Desmos project:  
`COSMOVISOR_VER = cosmovisor/v1.0.0`  
`GIT_NAME = umee-network`  
`GIT_FOLDER = umee`  
`BIN_NAME = umeed`  
`CONFIG_FOLDER = umee`  
`BIN_VER = v0.2.1`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh cosmovisor/v1.0.0 umee-network umee umeed umee v0.2.1
```

## 3. Data for start the chain. 
https://github.com/umee-network/umee/releases 
Binary link:
```
https://github.com/umee-network/umee/releases/download/v0.2.1/umeed-v0.2.1-linux-amd64.tar.gz
```
Chain-id:
```
umeevengers-1
```  
Genesis file:
```
Soon
```
Peers:
```
Soon
```
Seed:
```
Soon
```
minimum-gas-prices:
```
Soon
```

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart umeed.service`  
Cosmovisor service logs - `journalctl -u umeed.service -f`  
Stop Cosmovisor service - `systemctl stop umeed.service`  

## DONE
