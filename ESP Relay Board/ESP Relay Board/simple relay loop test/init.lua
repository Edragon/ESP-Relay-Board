dofile("relay_loop.lua")

wifi.sta.autoconnect(0)
 
-- ElectroDragon hardware
relay1pin = 7
relay2pin = 6
relayON = gpio.HIGH
relayOFF = gpio.LOW
statuspin = 0

-- Test settings
relayOnTime = 1
relayOffTime = 1
dutyCount = 100

--init pins
gpio.mode(statuspin,gpio.OUTPUT)
gpio.write(statuspin,gpio.LOW)
relaysInit()

--start test
relaysOn() 

print("set up wifi mode")
wifi.setmode(wifi.STATION)


tmr.alarm(1, 3000, 1, function() 
    if wifi.sta.getip() == nil then
        wifi.sta.config("hcwork","electrodragon")
        wifi.sta.connect()
        print("waiting ... ")
        gpio.write(statuspin,gpio.LOW)
    else
        print("Config done, IP is "..wifi.sta.getip())
        gpio.write(statuspin,gpio.HIGH)
        
    end
     
 end)
 
tmr.alarm(2, 10000, 1, function() 
        print("disconnect now and retry ...")
        wifi.sta.disconnect()
 end)
