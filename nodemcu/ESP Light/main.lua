MSC = require "board_misc"
CTRL = require "board_control"

gpio.mode(6, gpio.OUTPUT)
gpio.mode(7, gpio.OUTPUT)
-- timer ID 1 = status, 2,3 = relay, smart_config _ 4, 

files = file.list()  -- Lists all files in the file system.
CTRL.status_LED(100) -- blink status LED
MSC.BTN2_press()  -- button press interrupt io3

--dofile("wifi_net.lc")


if files["wifi_config.txt"] then
    wifi.setmode(wifi.STATIONAP)
    --wifi.sta.sethostname("mynode")
    -- do normal connect
    wifi.sta.autoconnect(1) -- auto connect
    MSC.wifi_conf_read()
    print(" Config exist, user>".. user .. ", pass>" .. password .. ", now set station mode and connect")
    
    wifi.sta.config(user, password)
    wifi.sta.connect()
    
    tmr.alarm(4, 5000, 1, function() 
        if wifi.sta.getip()== nil then
            print("IP unavailable.. waiting connecting ..")
            print("if ssid and pass correct then wait, else reconfig by press BTN2 to clean")
        else
            print("connected.. IP is: " .. wifi.sta.getip())
            
            if files["check_mode.txt"] then
                print("Running file mqtt_ctrl_ID")
                dofile("mqtt_ctrl_ID.lc")
            else
                print("Running file mqtt")
                dofile("mqtt_ctrl.lc")
            end

            tmr.stop(4)
        end
    end)
    
else
    wifi.setmode(wifi.STATION)
    -- do smart config
    wifi.sta.autoconnect(0) -- auto connect
    CTRL.relay_onoff() -- for test
    print("  Config file not exists, starting smartconfig..")
    CTRL.status_LED(200) -- blink status LED
    
    wifi.startsmart(0, function(ssid, password)
        print(string.format("Success. SSID: %s ; PASSWORD: %s", ssid, password)) 
        MSC.wifi_conf_write(ssid, password)
        wifi.sta.config(ssid, password)
        wifi.sta.connect() 
        wifi.sta.autoconnect(1) 
    end)

     -- check IP       
     tmr.alarm(4, 1000, 1, function() 
        if wifi.sta.getip()== nil then                          
        else
            wifi.stopsmart()
            print ("great, config done, restart!     ")
            node.restart()                
        end
    end)

end
