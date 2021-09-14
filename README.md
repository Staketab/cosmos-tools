# COSMOS Tools
List of tools for COSMOS projects.

# AUTOVISOR
Cosmos multi-network automation script for Cosmovisor setup.  

### 1. GOLANG #GO
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

### 2. Run AUTOVISOR setup and build.
Enter Enviroments `COSMOVISOR_VER GIT_NAME GIT_FOLDER BIN_NAME CONFIG_FOLDER BIN_VER` and run this script to setup and build.  
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh COSMOVISOR_VER GIT_NAME GIT_FOLDER BIN_NAME CONFIG_FOLDER BIN_VER
```
#### On the example of the Desmos project:  
`COSMOVISOR_VER = v0.42.9`  
`GIT_NAME = desmos-labs`  
`GIT_FOLDER = desmos`  
`BIN_NAME = desmos`  
`CONFIG_FOLDER = desmos`   
`BIN_VER = v0.16.0`

The run command should look like this:  
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh v0.42.9 desmos-labs desmos desmos desmos v0.16.0
```
### DONE
