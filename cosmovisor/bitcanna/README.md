# AUTOVISOR
Cosmos multi-network automation script for Cosmovisor - BITCANNA MAINNET.

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
`GIT_NAME = BitCannaGlobal`  
`GIT_FOLDER = bcna`  
`BIN_NAME = bcnad`  
`CONFIG_FOLDER = bcna`  
`BIN_VER = v1.1`

## The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh cosmovisor/v1.0.0 BitCannaGlobal bcna bcnad bcna v1.1
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
