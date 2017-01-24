CTRL = require "control"

MSC = require "misc"
mac_6 = MSC.get_mac6()

CON = require "mqtt_config"

--print ("mac last 6 digis is:   ".. mac_6)
--tmr.delay(10000)

CTRL.status_LED(6000)

--gpio6 = 6
--gpio.mode(gpio6, gpio.OUTPUT)
--gpio.write(gpio6, gpio.LOW)

--gpio7 = 7
--gpio.mode(gpio7, gpio.OUTPUT)
--gpio.write(gpio7, gpio.LOW)

--print (CON.MQTTPASS)

-- init mqtt client with keepalive timer 120sec
m = mqtt.Client(CON.ENDPOINT, 120, CON.MQTTUSER, CON.MQTTPASS)

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

  -- command switch to id control
  if topic == "Light1" then
    if data == mac_6.."ON" then
        print("switch to MAC last 6 digis ID control mode")
        MSC.con_idcontrol()
        node.restart()
    end
  end

  -- normal control  
  if topic == "Light1" then
    if data == "ON" then
        print("received message: ON @ light1")
        gpio.write(6, gpio.HIGH)
    end
    
    if data == "OFF" then
        print("received message: OFF @ light1")
        gpio.write(6, gpio.LOW)
    end
    
  end
    
  if topic == "Light2" then
    if data == "ON" then
        print("received message: ON @ light2")
        gpio.write(7, gpio.HIGH)
    end
    if data == "OFF" then
        print("received message: OFF @ light2")
        gpio.write(7, gpio.LOW)
    end
    
  end
     
end)

-- connect
m:connect(CON.HOST, CON.PORT, 0, function(conn)

    print("connecting to MQTT ...")
    --print("Your ID: " ..node.chipid())

    -- subscribe to topics
    m:subscribe( 
        { ["Light1"]=0, ["Light2"]=0}, function(conn) 
            print("subscribe on topics: Light1, 2")
    end)
    
    -- publish chip ID every 1 sec for 3 times
    tmr.alarm(2, 1000, tmr.ALARM_AUTO, function()
        m:publish("Light1", node.chipid(), 0, 0, function(conn) 
            print("publishing mac ID   " .. mac_6 ) 
        end)
    
    end)
    
    tmr.alarm(3, 3000, 0, function() tmr.stop(2) end)

    end, function(client, reason) print("failed reason: "..reason) end)
