# COSMOVISOR
Setup COSMOVISOR for SIFCHAIN BETANET.

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
Enter Enviroments on the example of the Sifchain project:
`COSMOVISOR_VER = v0.42.4`  
`GIT_NAME = Sifchain`  
`GIT_FOLDER = sifnode`  
`BIN_NAME = sifnoded`  
`BIN_FOLDER = sifnoded`  
`BIN_VER = mainnet-genesis`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh v0.42.4 Sifchain sifnode sifnoded sifnoded mainnet-genesis
```

## 3. Data for start the chain. 
Chain-id - `sifchain`  
Genesis file - [Link](https://raw.githubusercontent.com/Staketab/tools/main/cosmovisor/sifchain/genesis.json)  
Peers - `8c240f71f9e060277ce18dc09d82d3bbb05d1972@13.211.43.177:26656,0120f0a48e7e81cc98829ef4f5b39480f11ecd5a@52.76.185.17:26656,bcc2d07a14a8a0b3aa202e9ac106dec0bef91fda@13.55.247.60:26656,8c240f71f9e060277ce18dc09d82d3bbb05d1972@13.211.43.177:26656`  
Seed - `None`  
minimum-gas-prices - `0.025rowan`  

## DONE