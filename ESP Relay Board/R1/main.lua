misc = require "misc"
control = require "control"

-- timer ID 1 = status, 2,3 = relay, smart_config _ 4, 

files = file.list()  -- Lists all files in the file system.

control.status_LED(100) -- blink status LED

misc.BTN2_press()  -- button press interrupt io3

-- cause jamming twice boot
--misc.BTN1_press()  -- button press interrupt io4

--cfg={}
--cfg.ssid="Electrodragon"
--cfg.pwd="Electrodragon"
--wifi.ap.config(cfg)
 
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
            print("IP unavailable.. routing connecting ..")
            print("if ssid and pass correct then wait, else reconfig by press BTN2 to clean")
        else
            print("connected.. IP is: " .. wifi.sta.getip())
            
            if files["IDcontrol.txt"] then
                print("Running file mqtt_ID")
                dofile("mqtt_ID.lc")
            else
                print("Running file mqtt")
                dofile("mqtt.lc")
            end

            tmr.stop(4)
        end
    end)
    
else
    control.relay_onoff() -- for test

    tmr.alarm(4, 2000, 0, function() 
        if wifi.sta.getip()== nil then
            print("  Config file not exists, starting smartconfig..")
            control.status_LED(200) -- blink status LED
            wifi.startsmart(0,
                function(ssid, password)
                    print(string.format("Success. SSID: %s ; PASSWORD: %s", ssid, password)) 
                    misc.con_write(ssid, password)
                    tmr.alarm(5, 2000, 0, function()
                        node.restart()
                    end)
            end)
        else 
                  
            -- print("Config done, IP is "..wifi.sta.getip())
            -- wifi.stopsmart()
               --misc.con_write(ssid, password)
            --if files["IDcontrol.txt"] then
            --    print("Running specific mqtt_ID")
            --    dofile("mqtt_ID.lc")
            --else
            --    print("Running general mqtt")
            --    dofile("mqtt.lc")
            --end
            
            --tmr.stop(1) -- stop LED
            --tmr.stop(4) -- stop smart config
        end
    end)
        

end
