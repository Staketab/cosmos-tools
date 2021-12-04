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
`GIT_NAME = cosmos`  
`GIT_FOLDER = gaia`  
`BIN_NAME = gaiad`  
`CONFIG_FOLDER = gaia`  
`BIN_VER = v4.2.1`

The run command should look like this:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/node-installer/install.sh \
&& chmod +x install.sh \
&& ./install.sh -g cosmos -f gaia -b gaiad -c gaia -v v4.2.1 \
&& rm -rf install.sh && . $HOME/.profile
```

## 3. Data for start the chain. 
https://github.com/cosmos/gaia/releases  
Binary link:
```
https://github.com/cosmos/gaia/releases/download/v4.2.1/gaiad-v4.2.1-linux-amd64
```
Chain-id:
```
cosmoshub-4
```  
Genesis file:
```
https://github.com/cosmos/mainnet/raw/master/genesis.cosmoshub-4.json.gz
```
Peers:
```
bf8328b66dceb4987e5cd94430af66045e59899f@public-seed.cosmos.vitwit.com:26656,cfd785a4224c7940e9a10f6c1ab24c343e923bec@164.68.107.188:26656,d72b3011ed46d783e369fdf8ae2055b99a1e5074@173.249.50.25:26656,ba3bacc714817218562f743178228f23678b2873@public-seed-node.cosmoshub.certus.one:26656,3c7cad4154967a294b3ba1cc752e40e8779640ad@84.201.128.115:26656,ee27245d88c632a556cf72cc7f3587380c09b469@45.79.249.253:26656,538ebe0086f0f5e9ca922dae0462cc87e22f0a50@34.122.34.67:26656,d3209b9f88eec64f10555a11ecbf797bb0fa29f4@34.125.169.233:26656,bdc2c3d410ca7731411b7e46a252012323fbbf37@34.83.209.166:26656,585794737e6b318957088e645e17c0669f3b11fc@54.160.123.34:26656,df57f70cd3a104dcbd14d1aac9eb260c99a620e0@121.78.247.247:26656,11dfe200894f38e411beca77928e9dd118e66813@94.130.98.157:26656,5b4ed476e01c49b23851258d867cc0cfc0c10e58@206.189.4.227:26656,654f47a762c8f9257aef4a44c1fb5014916d8b20@99.79.60.15:26656,366ac852255c3ac8de17e11ae9ec814b8c68bddb@51.15.94.196:26656,547bfac343b9b4bd54ce9cb891c4bca3db2a0922@157.230.116.241:26656,d6318b3bd51a5e2b8ed08f2e520d50289ed32bf1@52.79.43.100:26656,1bfda3d59e70290a3dada9bb809dd954371850d3@54.180.225.240:26656,6ee94c2093505e8790442c054e6e1e0211d36583@44.239.140.195:26656,ec779a2741da6dd2ccdaa6dfc0bebb10e595dfa4@50.18.113.67:26656,047f723806ee702b211e7227f89eacd829aabd86@52.9.212.125:26656,cfd785a4224c7940e9a10f6c1ab24c343e923bec@164.68.107.188:26656,d72b3011ed46d783e369fdf8ae2055b99a1e5074@173.249.50.25:26656,b0e746acb6fbed7a0311fe21cfb2ee94581ca3bc@51.79.21.187:26656,82772547c4575c18dfe6e75aafe521cf7d4dc8de@142.93.157.186:26656,3c7cad4154967a294b3ba1cc752e40e8779640ad@84.201.128.115:26656,f122129f53b7c584df6cee77716dcc636d5c5e18@167.172.59.196:26656,241b17dba97a2ed3c3747d12781fb86c9706e2d4@95.179.136.131:26656,f1b16c603f3a0e59f0ce5179dc80f549a7ecd0e2@sentries.us-east1.iqext.net:26656
```
Seed:
```
bf8328b66dceb4987e5cd94430af66045e59899f@public-seed.cosmos.vitwit.com:26656,cfd785a4224c7940e9a10f6c1ab24c343e923bec@164.68.107.188:26656,d72b3011ed46d783e369fdf8ae2055b99a1e5074@173.249.50.25:26656,ba3bacc714817218562f743178228f23678b2873@public-seed-node.cosmoshub.certus.one:26656,3c7cad4154967a294b3ba1cc752e40e8779640ad@84.201.128.115:26656
```
minimum-gas-prices:
```
0.0025uatom
```

## 4. Service commands.
Reload configuration change - `sudo systemctl daemon-reload`  
Restart Cosmovisor service - `sudo systemctl restart gaiad.service`  
Cosmovisor service logs - `sudo journalctl -u gaiad.service -f`  
Stop Cosmovisor service - `sudo systemctl stop gaiad.service`  

## DONE
