# COSMOVISOR
Setup COSMOVISOR for SIFCHAIN project.

### 1. Install GOLANG.
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

### 2. Run COSMOVISOR setup and build.
Enter Enviroments on the example of the Sifchain project:
`COSMOVISOR_VER = v0.42.4`  
`GIT_NAME = Sifchain`  
`GIT_FOLDER = sifnode`  
`BIN_NAME = sifnoded`  
`BIN_VER = mainnet-genesis`

The run command should look like this:
```
wget https://raw.githubusercontent.com/icohigh/node-tools/main/cosmovisor/cosmovisor.sh \
&& chmod +x cosmovisor.sh \
&& ./cosmovisor.sh v0.42.4 Sifchain sifnode sifnoded mainnet-genesis
```
### DONE