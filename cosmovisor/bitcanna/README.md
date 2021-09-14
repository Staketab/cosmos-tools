# AUTOVISOR
Cosmos multi-network automation script for Cosmovisor - BITCANNA TESTNET.

## 1. Install GOLANG.
Install custom version of Golang #GO. 
Specify version in this line `./install.sh -v VERSION`
Example `./install.sh -v 1.16.5`

Or you can install GO from [official website](https://golang.org/doc/install).
```
wget https://raw.githubusercontent.com/Staketab/node-tools/main/components/golang/install.sh \
&& chmod +x install.sh \
&& ./install.sh -v 1.16.5
```
Reboot your terminal after installing.

## 2. Run COSMOVISOR setup and build.
Enter Enviroments on the example of the Desmos project:  
`COSMOVISOR_VER = v0.42.9`  
`GIT_NAME = BitCannaGlobal`  
`GIT_FOLDER = bcna`  
`BIN_NAME = bcnad`  
`CONFIG_FOLDER = bcna`  
`BIN_VER = v0.2-beta`

## The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh v0.42.9 BitCannaGlobal bcna bcnad bcna v0.2-beta
```

## 3. Data for start the chain. 
Binary link:
```
https://github.com/BitCannaGlobal/bcna/releases/download/v0.2-beta/bcnad
```
Chain-id:
```
bitcanna-testnet-6
```  
Genesis file:
```
https://raw.githubusercontent.com/BitCannaGlobal/testnet-bcna-cosmos/main/instructions/public-testnet/genesis.json
```
Peers:
```
d6aa4c9f3ccecb0cc52109a95962b4618d69dd3f@seed1.bitcanna.io:26656,23671067d0fd40aec523290585c7d8e91034a771@seed2.bitcanna.io:26656
```
Seed:
```
d6aa4c9f3ccecb0cc52109a95962b4618d69dd3f@seed1.bitcanna.io:26656,23671067d0fd40aec523290585c7d8e91034a771@seed2.bitcanna.io:26656
```
minimum-gas-prices:
```
0.01ubcna
```

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart bcnad.service`  
Cosmovisor service logs - `journalctl -u bcnad.service -f`  
Stop Cosmovisor service - `systemctl stop bcnad.service`  

## DONE
