CTRL_D = require "board_control"
MSC_D = require "board_misc"

mac_6 = MSC_D.get_mac6()

MSC_D.brd_check_server()
CON_D = require (server_use)

--tmr.delay(1000)

CTRL_D.status_LED(5000)

--gpio6 = 6
--gpio.mode(gpio6, gpio.OUTPUT)
--gpio.write(gpio6, gpio.LOW)

--gpio7 = 7
--gpio.mode(gpio7, gpio.OUTPUT)
--gpio.write(gpio7, gpio.LOW)

--print (CON.MQTTPASS)

-- init mqtt client with keepalive timer 120sec
m = mqtt.Client(CON_D.ENDPOINT, 120, CON_D.MQTTUSER, CON_D.MQTTPASS)

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
  if topic == tostring(mac_6) then
    --print ("topic match")
    if data == "1ON" then
        print("received message: 1ON")
        gpio.write(6, gpio.HIGH)  
    elseif data == "1OFF" then
        print("received message: 1OFF")
        gpio.write(6, gpio.LOW)
       
    elseif data == "2ON" then
        print("received message: 2ON")
        gpio.write(7, gpio.HIGH)    
    elseif data == "2OFF" then
        print("received message: 2OFF")
        gpio.write(7, gpio.LOW)

    elseif string.sub(data, 1, 6) == "server" then
        MSC_D.brd_write_server(string.sub(data, 7,7))
        node.restart()   
    end
        
  end

     
end)



-- connect
m:connect(CON_D.HOST, CON_D.PORT, 0, function(conn)
    print("connecting to MQTT")
    --print("Your ID: " ..node.chipid())

    m:subscribe(mac_6, 0, function(conn) 
            print("subscribe on topics: " .. mac_6)

    m:publish(mac_6, mac_6 .. " Board online!", 0, 0, function(conn) 
            print(mac_6 .. " Board online!") 
        end)
        
    end)


end, function(client, reason) print("failed reason: "..reason) end)
