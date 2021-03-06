CTRL = require "board_control"
MSC = require "board_misc"

mac_6 = MSC.get_mac6()

MSC.brd_check_server()
CON = require (server_use)

dofile("wifi_pwm.lc")

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
        MSC.brd_check_mode()
        node.restart()

            
    elseif data == "ON" then
        print("received message: ON @ light1")
        led(512, 512, 512) --  set led to ON
    
    elseif data == "OFF" then
        print("received message: OFF @ light1")
        led(0, 0, 0) --  set led to OFF

    elseif data == "DIM" then
        print("received message: DIM @ light1")
        led(50, 50, 50) --  set led to DIM
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
        m:publish("Light1", "Last 6 mac addr:  " .. mac_6, 0, 0, function(conn) 
            print("publishing mac ID   " .. mac_6 ) 
        end)
    
    end)
    
    tmr.alarm(3, 3000, 0, function() tmr.stop(2) end)

    end, function(client, reason) print("failed reason: "..reason) end)
