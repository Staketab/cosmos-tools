# COSMOVISOR
Setup COSMOVISOR for OSMOSIS MAINNET.

## 1. Install GOLANG.
Install custom version of Golang #GO. 
Specify version in this line `./install.sh -v VERSION`
Example `./install.sh -v 1.15.7`

Or you can install GO from [official website](https://golang.org/doc/install).
```
wget https://raw.githubusercontent.com/Staketab/tools/main/golang/install.sh \
&& chmod +x install.sh \
&& ./install.sh -v 1.15.7
```
Reboot your terminal after installing.

## 2. Run COSMOVISOR setup and build.
Enter Enviroments on the example of the Osmosis project:  
`COSMOVISOR_VER = v0.42.5`  
`GIT_NAME = osmosis-labs`  
`GIT_FOLDER = osmosis`  
`BIN_NAME = osmosisd`  
`CONFIG_FOLDER = osmosisd`  
`BIN_VER = v1.0.1`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh v0.42.5 osmosis-labs osmosis osmosisd osmosisd v1.0.1
```

## 3. Data for start the chain. 
Chain-id - `osmosis-1`  
Genesis file - [Link](https://media.githubusercontent.com/media/osmosis-labs/networks/main/osmosis-1/genesis.json)  
Peers - `8f67a2fcdd7ade970b1983bf1697111d35dfdd6f@52.79.199.137:26656,00c328a33578466c711874ec5ee7ada75951f99a@35.82.201.64:26656,cfb6f2d686014135d4a6034aa6645abd0020cac6@52.79.88.57:26656,8d9967d5f865c68f6fe2630c0f725b0363554e77@134.255.252.173:26656,785bc83577e3980545bac051de8f57a9fd82695f@194.233.164.146:26656,778fdedf6effe996f039f22901a3360bc838b52e@161.97.187.189:36656,64d36f3a186a113c02db0cf7c588c7c85d946b5b@209.97.132.170:26656,4d9ac3510d9f5cfc975a28eb2a7b8da866f7bc47@37.187.38.191:26656,2115945f074ddb038de5d835e287fa03e32f0628@95.217.43.85:26656,bf2c480eff178d2647ba1adfeee8ced568fe752c@91.65.128.44:26656,2f9c16151400d8516b0f58c030b3595be20b804c@37.120.245.167:26656,7024d1ca024d5e33e7dc1dcb5ed08349768220b9@134.122.42.20:26656,d326ad6dffa7763853982f334022944259b4e7f4@143.110.212.33:26656,9faf468b90a3b2b85ffd88645a15b3715f68bb0b@195.201.122.100:26656,fda06dcebe2acd17857a6c9e9a7b365da3771ceb@52.206.252.176:26656`  
Seed - `83adaa38d1c15450056050fd4c9763fcc7e02e2c@ec2-44-234-84-104.us-west-2.compute.amazonaws.com:26656 23142ab5d94ad7fa3433a889dcd3c6bb6d5f247d@95.217.193.163:26656 f82d1a360dc92d4e74fdc2c8e32f4239e59aebdf@95.217.121.243:26656 e437756a853061cc6f1639c2ac997d9f7e84be67@144.76.183.180:26656`  
minimum-gas-prices - `0.025uosmo`  

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart cosmovisor.service`  
Cosmovisor service logs - `journalctl -u cosmovisor.service -f`  
Stop Cosmovisor service - `systemctl stop cosmovisor.service`  

## DONE
