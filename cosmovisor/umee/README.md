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
https://raw.githubusercontent.com/umee-network/testnets/main/networks/umeevengers-1/genesis.json
```
Peers:
```
002a3f0357bdd186aeaa220f8ae3a0ef2e913021@162.55.135.244:26656,0250f915e0dfa30c7b4313b4a02b17ce754e8eb4@176.57.189.170:26656,031136cd02c8e7555068cd67943270849ddd230c@194.163.172.20:26656,047a9dfd526ec52940f3fc0d151e74d1c8d94797@88.198.2.8:26656,048fe3cee7d2edabf90aef7c42bd371966b4c501@172.22.205.148:26656,06e451c2c74e8b7ea3e52b00f0c9b737cc6be822@65.21.242.137:26656,094accc8d9568cb3b29318590f3e7d1549cdf32f@65.108.83.8:26656,0a67e728b6a6a60cd498bb3cfa0b47c71e5f6336@62.171.134.255:26656,0a881e4e534c481d4fe3ed86e034b9d13df618b0@89.163.206.250:26656,0b25af057da9e0bcbebd231a1d0ab6e8b40955fe@23.88.109.180:26656,0d0f7164cf1e92bdd41dee6f4647e304ad1663aa@10.178.0.3:26656,0e5eef8ec3d294701c7e36df7249e59038ad74b8@134.209.64.229:26656,10c10081581f5c733878bfb837b7c3e07d71288c@49.12.208.6:26656,123f6d6b3041cfd371b1a6b2f98953d955aec578@161.97.81.240:26656,1694e2cd89b03270577e547d7d84ebef13e4eff1@172.105.168.226:26656,1884705a9bfc0e972e4bdae429ce3f3e7f5c8c7e@157.90.179.34:26656,189d01f44f0e5fd515c9bd155620804b979466a9@135.181.25.143:26656,19ea726fc678ba389908587dd70fdf050a62f9af@95.217.10.148:26656,1aa5aa6f1f8049bfff15916ff76c8dcdba9cbe20@95.217.135.247:26656,1c08a56d9c52ed2b63c9468f4be24064a234afc7@10.10.10.21:26656,1cc72a14157312ebae7574522f2fb547354fa095@134.209.158.119:26656,1ce0be1d4aa96a43bdf354129d9303ad923abba5@192.168.0.100:26656,2034815d221fc2ddf2fbbd1f9c531b2626d30324@109.205.182.110:26656,20a9adbe9dc9fc8aa9b523d9f1f246396a8f4e62@23.88.99.206:26656,22c57df0a41cbff95ca863950952de7518bd2a99@85.14.222.161:26656,22ddb078b7637e9dab061933be1d5ff2005282c4@95.217.112.148:26656,231f5cc70b16e8d3e803c17ff27bf4aa56396d9f@65.108.41.36:26656,2323d08747bf1b8164dcd9627d59a9c8b4de9120@161.97.183.135:26656,290484f88fdea05cd2228e0ab93d1ffe161dc899@192.168.1.46:26656,29ec8ebb5495993c8e48438c47cbf5731b4d381d@136.243.205.2:26656,2a2ea02ac08f17fb891a84d3ac28381be0151788@172.31.15.189:26656,2c5feaec86e4f1e135e4ca132458c179fc10cafd@10.1.0.4:26656,2cd788d29704fca9e1372afccaaccc167c2bc2ec@62.171.142.94:26656,2d4133df620595c51d44a9a065c3f3119669e50e@211.1.227.39:26656,30b1530fb4cbcedbffd7046028b30c1d276ffa72@172.16.0.2:26656,314609b544e40d6f5d38e8bb450eb0c84356a7f7@144.91.74.165:26656,3276149d9192aa17c8dbdec91916729a72ed56b1@49.12.192.208:26656,329126078ca94606ca4e110d11194efd35a02bdd@172.30.10.111:26656,33ce7db4fb291d3c2326bed081425aeda44ea2d7@136.243.16.232:26656,382a5795f1e4029c4f0cb691d23fbea9c2e40c10@178.18.241.220:26656,3b9265d2be57ec6166f66d4b5178a468e6b934cd@194.163.176.28:26656,3bb2ede43859cb4000d1d9cffd75403ad5f06693@10.8.26.101:26656,3bc0136ac4411974a7820a9e327beebe4b9729b9@116.203.50.176:26656,3c6d0fca386e35dae4655802c25a98ad9810df1a@95.217.119.24:26656,3dd9613d16c92ba01f6d4fccc26cced18e0b166b@144.91.127.184:26656,3e1be3f6f9f96be102b57496fef3a60f15c5ab45@161.97.182.71:26656,3f418e684207998a27b295256800a1be24b2c1a0@135.181.56.56:26656,3f706a79444a9589d9a9ec4466fa98676aa51358@65.108.10.252:26656,40c46f3079d29f51822ef7a6edd6991a9d43b2f7@159.69.197.114:26656,424fa5a691afc7c156351186d0bff1d80194877b@178.62.237.160:26656
```
Seed:
```
none
```
minimum-gas-prices:
```
none
```

## 4. Service commands.
Reload configuration change - `systemctl daemon-reload`  
Restart Cosmovisor service - `systemctl restart umeed.service`  
Cosmovisor service logs - `journalctl -u umeed.service -f`  
Stop Cosmovisor service - `systemctl stop umeed.service`  

## DONE
