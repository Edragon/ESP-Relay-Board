misc = require "misc"
LED = require "LEDblink"

files = file.list()

misc.button_press()
--misc.button_rst()

LED.blink0(0, 300, 2)
    
if files["config.txt"] then
    misc.con_read()
    --tmr.delay(1000000)
    print(" Config exist, user>".. user .. ", pass>" .. password .. ", now set station mode and connect")
    wifi.setmode(wifi.STATION)
    wifi.sta.config(user, password)
    wifi.sta.connect()
    wifi.sta.autoconnect(1)
    tmr.alarm(1, 5000, 1, function() 
        if wifi.sta.getip()== nil then
            print("IP unavailable.. if info correct then wait, else reconfig by press BTN1 to clean")
        else
            print("connected.. IP is: " .. wifi.sta.getip())
            tmr.stop(1)
            dofile("mqtt.lua")
        end
    end)
else
    print("  Config file NOT exists, starting smartconfig..")
    wifi.setmode(wifi.STATION)
    LED.blink1(6, 1000, 3)
    LED.blink2(7, 1000, 4)
    tmr.alarm(1, 5000, 1, function() 
        if wifi.sta.getip()== nil then
            wifi.startsmart(0,
            function(ssid, password)
            print(string.format("Success. SSID: %s ; PASSWORD: %s", ssid, password)) 
            misc.con_write(ssid, password)
            end)
        else 
            tmr.stop(1)
            tmr.stop(2)
            tmr.stop(3)
            tmr.stop(4)
            print("Config done, IP is "..wifi.sta.getip())
            wifi.stopsmart()

            --misc.con_read()
            --print (user .. password)
            dofile("mqtt.lua")
        end
    end)
        

end
