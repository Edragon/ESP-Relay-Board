control = require "control"

mconf = require "mqtt_config"

tmr.delay(1000)

control.status_LED(3000)

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
cid = node.chipid()
-- on / message event
m:on("message", function(conn, topic, data)
  print(topic .. " event received" )
  --print(data)  
  if topic == tostring(node.chipid()) then
    --print ("topic match")
    if data == "1ON" then
        print("received message: 1ON")
        gpio.write(gpio6, gpio.HIGH)  
    elseif data == "1OFF" then
        print("received message: 1OFF")
        gpio.write(gpio6, gpio.LOW)
    elseif data == "2ON" then
        print("received message: 2ON")
        gpio.write(gpio7, gpio.HIGH)    
    elseif data == "2OFF" then
        print("received message: 2OFF")
        gpio.write(gpio7, gpio.LOW)
    end
        
  end

     
end)



-- connect
m:connect(mconf.HOST, mconf.PORT, 0, function(conn)
    print("connecting to MQTT")
    --print("Your ID: " ..node.chipid())

    m:subscribe(node.chipid(), 0, function(conn) 
            print("subscribe on topics: " .. node.chipid() )
    end)


end, function(client, reason) print("failed reason: "..reason) end)
