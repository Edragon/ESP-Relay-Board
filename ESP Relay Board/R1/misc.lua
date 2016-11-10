local M = {}

function M.con_read()
    -- read user and pass
    file.open("config.txt", "r")
    user = file.readline():gsub("%s+$", "")
    password = file.readline():gsub("%s+$", "")
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


function trig()
    print("BTN2 button pressed")
    file.remove("config.txt")
    node.restart()
end

function M.button_press()
    gpio.mode(3, gpio.INT, gpio.PULLUP)
    gpio.trig(3, "down", trig)  -- run fun trig finally
end


function rst()
    print("BTN1 button pressed")
    node.restart()
end

function M.button_rst()
    gpio.mode(4, gpio.INT, gpio.PULLUP)
    gpio.trig(4, "down", rst)   -- run fun trig finally
end


return M
