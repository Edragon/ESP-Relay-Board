control = require "control"

mconf = require "mqtt_config"

tmr.delay(100000)

control.status_LED(5000)

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
  print(topic.. " event received" )
  
  if topic == "ID" then
    if data == node.chipid().."ON" then
        print("switch to ID control mode")
        misc.con_idcontrol()
        node.restart()
    end
  end
    
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

-- connect
m:connect(mconf.HOST, mconf.PORT, 0, function(conn)

    print("connecting to MQTT ...")
    --print("Your ID: " ..node.chipid())

    -- subscribe to topics
    m:subscribe( 
        { ["Light1"]=0, ["Light2"]=0, ["ID"]=0 }, function(conn) 
            print("subscribe on topics: Light1, 2 and ID")
    end)
    
    -- publish chip ID
    tmr.alarm(2, 5000, tmr.ALARM_AUTO, function()
        m:publish("ID", node.chipid(), 0, 0, function(conn) 
            print("publishing chip ID   " .. node.chipid() ) 
        end)
    
    end)
    
    tmr.alarm(3, 21000, 0, function() tmr.stop(2) end)
    
    -- ADC
    --tmr.alarm(2, 5000, tmr.ALARM_AUTO, function()
    --    m:publish("ADCnow", adc.read(0),0,0, function(conn) 
    --        print("sent ADC") 
    --    end)
    --end)

end, function(client, reason) print("failed reason: "..reason) end)
