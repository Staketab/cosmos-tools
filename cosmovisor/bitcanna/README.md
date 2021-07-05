# COSMOVISOR
Setup COSMOVISOR for BITCANNA TESTNET.

## 1. Install GOLANG.
Install custom version of Golang #GO. 
Specify version in this line `./install.sh -v VERSION`
Example `./install.sh -v 1.15.7`

Or you can install GO from [official website](https://golang.org/doc/install).
```
wget https://raw.githubusercontent.com/Staketab/node-tools/main/components/golang/install.sh \
&& chmod +x install.sh \
&& ./install.sh -v 1.15.7
```
Reboot your terminal after installing.

## 2. Run COSMOVISOR setup and build.
Enter Enviroments on the example of the Desmos project:  
`COSMOVISOR_VER = v0.42.6`  
`GIT_NAME = BitCannaGlobal`  
`GIT_FOLDER = testnet-bcna-cosmos`  
`BIN_NAME = bcnad`  
`CONFIG_FOLDER = bcna`  
`BIN_VER = v0.testnet6`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh v0.42.4 BitCannaGlobal testnet-bcna-cosmos bcnad bcna v0.testnet6
```

## 3. Data for start the chain. 
Chain-id - `bitcanna-testnet-4`  
Genesis file - [Link](https://raw.githubusercontent.com/BitCannaGlobal/testnet-bcna-cosmos/main/instructions/stage4/genesis.json)  
Peers - `d6aa4c9f3ccecb0cc52109a95962b4618d69dd3f@seed1.bitcanna.io:26656,41d373d03f93a3dc883ba4c1b9b7a781ead53d76@seed2.bitcanna.io:16656`  
Seed - `42dd0eeb50510e5ad71ea7c9183bd2a0619000e6@135.181.73.109:26656,a60f5ce8cd0705c8b9e052dd91ab7d58ccdbbfd9@94.130.136.77:46656,d6aa4c9f3ccecb0cc52109a95962b4618d69dd3f@seed1.bitcanna.io:26656,41d373d03f93a3dc883ba4c1b9b7a781ead53d76@seed2.bitcanna.io:16656,acc177d5af9fad3064c1831bba41718d5f0ef2ce@167.71.0.53:26656,0f42474822f65d3955d91b910f172b8708418324@176.223.140.165:26656,14b89bebb8d380b15cc8c1fa6b1c53e3caa0a0c2@157.90.240.131:26656,42dd0eeb50510e5ad71ea7c9183bd2a0619000e6@135.181.73.109:26656,a60f5ce8cd0705c8b9e052dd91ab7d58ccdbbfd9@94.130.136.77:46656`  
minimum-gas-prices - `0.01ubcna`  

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart cosmovisor.service`  
Cosmovisor service logs - `journalctl -u cosmovisor.service -f`  
Stop Cosmovisor service - `systemctl stop cosmovisor.service`  

## DONE
