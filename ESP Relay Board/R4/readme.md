## file system and workflow 
init.lua -> main.lua  
main.lua check wifi_config.txt  
&emsp;&emsp;yes -> connect  
&emsp;&emsp;ID registered check  
&emsp;&emsp;&emsp;&emsp;yes -> run file mqtt_ID.lc  
&emsp;&emsp;&emsp;&emsp;no -> run file mqtt.lc  
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;command to switch to mqtt_ID.lc control  
&emsp;&emsp;&emsp;&emsp;no -> smartconfig  
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;connected -> write into config.txt and restart  

## files
* init.lua - check main lua or lc to use
* main.lua - main lua
---
* board_misc.lua - write read files
* board_control.lua - board led and relay control
---
* wifi_net.lua - TCP server connection
---
* mqtt_ctrl.lua - mqtt control
* mqtt_ctrl_ID.lua - mqtt control by mac ID
* mqtt_server_1.lua - mqtt server details config


## system generated files
* check_mode.txt - check if switched to ID control mode
* check_server.txt - check which server to use, in file 1 = server, etc
---
* wifi_config.txt - wifi ssid and password save file