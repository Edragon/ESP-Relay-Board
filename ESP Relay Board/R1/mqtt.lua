control = require "control"

mconf = require "mqtt_config"

print("Running file mqtt")
tmr.delay(100000)

control.status_LED(2000)

gpio6 = 6
gpio.mode(gpio6, gpio.OUTPUT)
gpio.write(gpio6, gpio.LOW)

gpio7 = 7
gpio.mode(gpio7, gpio.OUTPUT)
gpio.write(gpio7, gpio.LOW)

--print (mconf.MQTTPASS)

-- init mqtt client with keepalive timer 120sec
m = mqtt.Client(mconf.ENDPOINT, 120, mconf.MQTTUSER, mconf.MQTTPASS)

-- setup Last Will and Testament (optional)
-- Broker will publish a message with qos = 0, retain = 0, data = "offline" 
-- to topic "/lwt" if client don't send keepalive packet
m:lwt("/lwt", "offline", 0, 0)

-- on / connect and offline event
m:on("connect", function(client) print ("device connected event") end)
m:on("offline", function(client) print ("device offline event") end)

-- on / message event
m:on("message", function(conn, topic, data)
  print(topic.. " event registered" )
  if topic == "Light1" then
    if data == "ON" then
        print("received message: ON @ light1")
        gpio.write(gpio6, gpio.HIGH)
    end
    if data == "OFF" then
        print("received message: OFF @ light1")
        gpio.write(gpio6, gpio.LOW)
    end
    
  end
    
  if topic == "Light2" then
    if data == "ON" then
        print("received message: ON @ light2")
        gpio.write(gpio7, gpio.HIGH)
    end
    if data == "OFF" then
        print("received message: OFF @ light2")
        gpio.write(gpio7, gpio.LOW)
    end
    
  end
     
end)

-- send0/publish chip ID

m:connect(mconf.HOST, mconf.PORT, 0, function(conn)

    print("connected")
    print("Your ID: " ..node.chipid())
    -- subscribe both topic

    m:subscribe({["Light1"]=0, ["Light2"]=0}, function(conn) 
        print("subscribe Light 1 and 2 success")
    end)
            
    m:publish("ID is: ", node.chipid(),0,0, function(conn) 
        print("sent ID") 
    end)
    
    tmr.alarm(2, 5000, tmr.ALARM_AUTO, function()
        m:publish("ADCnow", adc.read(0),0,0, function(conn) 
            print("sent ADC") 
        end)
    end)

end, function(client, reason) print("failed reason: "..reason) end)
