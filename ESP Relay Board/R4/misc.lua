-- alarm None

local M = {}

function M.con_read() 
    -- read user and pass
    file.open("config.txt", "r")
    user = file.readline():gsub("%s+$", "")
    password = file.readline():gsub("%s+$", "")
    --control = file.readline():gsub("%s+$", "")
    file.close()
end

function M.con_write(user, pass)
    -- write user and pass
    file.remove("config.txt")
    file.open("config.txt", "w")
    file.writeline(user)
    file.writeline(pass)
    file.close()
end

function M.con_idcontrol()
    -- make file, use ID control
    file.open("registered.txt", "w")
    file.writeline("nothing, file existx")
    file.close()
end

-- BTN2
function trig()
    -- BTN2 action
    print("BTN2 button pressed")
    file.remove("config.txt")
    file.remove("registered.txt")
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
