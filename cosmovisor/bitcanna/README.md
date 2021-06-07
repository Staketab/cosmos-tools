# COSMOVISOR
Setup COSMOVISOR for BITCANNA TESTNET.

## 1. Install GOLANG.
Install custom version of Golang #GO. 
Specify version in this line `./install.sh -v VERSION`
Example `./install.sh -v 1.15.7`

Or you can install GO from [official website](https://golang.org/doc/install).
```
wget https://raw.githubusercontent.com/icohigh/node-tools/main/golang/install.sh \
&& chmod +x install.sh \
&& ./install.sh -v 1.15.7
```
Reboot your terminal after installing.

## 2. Run COSMOVISOR setup and build.
Enter Enviroments on the example of the Desmos project:
`COSMOVISOR_VER = v0.42.4`  
`GIT_NAME = BitCannaGlobal`  
`GIT_FOLDER = testnet-bcna-cosmos`  
`BIN_NAME = bcnad`  
`CONFIG_FOLDER = bcna`  
`BIN_VER = v0.testnet6`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh v0.42.4 BitCannaGlobal testnet-bcna-cosmos bcnad bcna v0.testnet6
```

## 3. Data for start the chain. 
Chain-id - `bitcanna-testnet-2`  
Genesis file - [Link](https://raw.githubusercontent.com/BitCannaGlobal/testnet-bcna-cosmos/main/instructions/stage1/genesis.json)  
Peers - `d6aa4c9f3ccecb0cc52109a95962b4618d69dd3f@seed1.bitcanna.io:26656,41d373d03f93a3dc883ba4c1b9b7a781ead53d76@seed2.bitcanna.io:16656`  
Seed - `d6aa4c9f3ccecb0cc52109a95962b4618d69dd3f@seed1.bitcanna.io:26656,41d373d03f93a3dc883ba4c1b9b7a781ead53d76@seed2.bitcanna.io:16656`  
minimum-gas-prices - `0.01ubcna`  

## DONE
