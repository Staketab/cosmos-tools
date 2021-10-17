# AUTO UNJAIL YOUR VALIDATOR SCRIPT.
Install script for auto-unjail your Validator.  
### Features:  
- You can specify a custom RPC port
- Custom FEES
- Custom Sleep Time in minutes
- Send message about delegation to Telegram
- It is enough to enter in the variables only the password, binary and key name in the start command
- No need to edit config

Specify environments in this line `./start.sh -b BINARY -k KEY_NAME -s SLEEP_TIME -p RPC_PORT -t TG_TOKEN -c TG_CHANNEL`  
Example `./start.sh -b umeed -k staketab2 -s 10 -p 36657 -t 1948967210:ATrsFGHJEpdYPO81S13nzn56FgcE_YA-t_S -c -1542578945875`  
`-s 10` - value in minutes  
### You can use like all variables, some or set only `-b BINARY` and `-k KEY_NAME`.

Start new `TMUX` session:
```
tmux new -s unjail
```
And start this script:
```
wget https://raw.githubusercontent.com/Staketab/cosmos-tools/main/auto-unjail/unjail.sh \
&& chmod +x start.sh \
&& ./start.sh -b BINARY -k KEY_NAME -s SLEEP_TIME -p RPC_PORT -t TG_TOKEN -c TG_CHANNEL
```
## SCREENSHOT EXAMPLE: 
## `Tmux screen:`  
![alt_tag](src/unjail.png)
