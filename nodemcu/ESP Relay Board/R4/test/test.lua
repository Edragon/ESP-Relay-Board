    file.open("check_server.txt", "r")
    server_num = file.readline()
    
    if server_num == "1" then
        server_use = "mqtt_server_1"
    elseif server_num == "2" then
        server_use = "mqtt_server_2"
    elseif server_num == "3" then
        server_use = "mqtt_server_3"
    end

    print (server_use)
    
    CON = require (server_use)

    print (CON.HOST)