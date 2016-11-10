misc = require "misc"
control = require "control"

-- timer 1 = status, 2,3 = relay 

files = file.list()  -- Lists all files in the file system.

misc.button_press()  -- button press interrupt io3
--misc.button_rst()

control.status_LED(300) -- blink status LED

wifi.setmode(wifi.STATION)
wifi.sta.autoconnect(0) -- auto connect

if files["config.txt"] then
    misc.con_read()
    --tmr.delay(1000000)
    print(" Config exist, user>".. user .. ", pass>" .. password .. ", now set station mode and connect")
    
    wifi.sta.config(user, password)
    wifi.sta.connect()
    
    tmr.alarm(4, 5000, 1, function() 
        if wifi.sta.getip()== nil then
            print("IP unavailable.. if info correct then wait, else reconfig by press BTN1 to clean")
        else
            print("connected.. IP is: " .. wifi.sta.getip())
            tmr.stop(4)
            dofile("mqtt.lua")
        end
    end)
    
else
    control.relay_onoff() -- for test

    tmr.alarm(4, 5000, 1, function() 
        if wifi.sta.getip()== nil then
            print("  Config file NOT exists, starting smartconfig..")
            wifi.startsmart(0,
            function(ssid, password)
            print(string.format("Success. SSID: %s ; PASSWORD: %s", ssid, password)) 
            misc.con_write(ssid, password)
            end)
        else 
            tmr.stop(1)

            tmr.stop(4)
            print("Config done, IP is "..wifi.sta.getip())
            wifi.stopsmart()

            --misc.con_read()
            --print (user .. password)
            dofile("mqtt.lua")
        end
    end)
        

end
