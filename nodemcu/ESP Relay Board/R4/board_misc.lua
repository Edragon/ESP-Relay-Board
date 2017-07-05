-- alarm None

local M = {}

function M.wifi_conf_read() 
    -- read user and pass
    file.open("wifi_config.txt", "r")
    user = file.readline():gsub("%s+$", "")
    password = file.readline():gsub("%s+$", "")
    --control = file.readline():gsub("%s+$", "")
    file.close()
end

function M.wifi_conf_write(user, pass)
    -- write user and pass
    file.remove("wifi_config.txt")
    file.open("wifi_config.txt", "w")
    file.writeline(user)
    file.writeline(pass)
    file.close()
end

function M.brd_check_mode()
    -- make file, use ID control
    file.open("check_mode.txt", "w")
    file.writeline("save mode")
    file.close()
end

function M.brd_check_server()
    -- make file, use ID control
    file.open("check_server.txt", "r")
    server_num = file.readline()
    
    if server_num == "1" then
        server_use = "mqtt_server_1"
        print ("using server-1")
    elseif server_num == "2" then
        server_use = "mqtt_server_2"
        print ("using server-2")
    elseif server_num == "3" then
        server_use = "mqtt_server_3"
        print ("using server-3")
    end
    file.close()     
end

function M.brd_write_server(server_write)
    -- make file, use ID control
    file.remove("check_server.txt")
    file.open("check_server.txt", "w")
    file.write(server_write)
    file.close() 
end

-- BTN2
function trig()
    -- BTN2 action
    print("BTN2 button pressed")
    file.remove("wifi_config.txt")
    file.remove("check_mode.txt")
    tmr.alarm(6, 2000, 0, function()
        node.restart()
    end)
end

function M.BTN2_press()
    gpio.mode(3, gpio.INT, gpio.PULLUP)
    gpio.trig(3, "down", trig)  -- run fun trig finally
end

-- BTN1
function rst()
    print("BTN1 button pressed")
    node.restart()
end

function M.BTN1_press()
    gpio.mode(4, gpio.INT, gpio.PULLUP)
    gpio.trig(4, "down", rst)   -- run fun trig finally
end

function M.get_mac6()
    -- get last 6 mac address
    r_mac = wifi.sta.getmac()
    mac6 = string.sub(r_mac, 10,11)..string.sub(r_mac, 13,14)..string.sub(r_mac, 16,17)
    mac_6 = string.upper(mac6)
    return mac_6
end

return M
