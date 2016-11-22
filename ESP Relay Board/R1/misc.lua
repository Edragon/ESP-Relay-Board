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
    file.open("IDcontrol.txt", "w")
    file.writeline("nothing, file existx")
    file.close()
end

-- BTN2
function trig()
    print("BTN2 button pressed")
    file.remove("config.txt")
    file.remove("IDcontrol.txt")
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


return M
