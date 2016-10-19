-- Test parameters (settings in init.lua)
-- relayOnTime = 2
-- relayOffTime = 2
-- dutyCount = 10

function relaysInit()
	gpio.mode(relay1pin,gpio.OUTPUT) 
	gpio.write(relay1pin,relayOFF)
	gpio.mode(relay2pin,gpio.OUTPUT) 
	gpio.write(relay2pin,relayOFF)
end

function relaysOn()
    cycle = 0
    stage1()
end

function stage1()
    cycle = cycle + 1
    print ("relay ON", cycle)
    gpio.write(relay1pin,relayON)
    gpio.write(relay2pin,relayON)
    net.dns.resolve("www.baidu.com", function(sk, ip)
        if (ip == nil) then print("DNS fail!") else print("baidu IP is: " .. ip) end
    end)    
    tmr.alarm(3, relayOnTime * 1000, 0, stage2)
end

function stage2()
    relaysOff()
    if cycle < dutyCount then
    	tmr.alarm(3, relayOffTime * 1000, 0, stage1)
	else
		print ("test finished")
    end
end

function relaysOff()
    gpio.write(relay1pin,relayOFF)
    gpio.write(relay2pin,relayOFF)
end

function relaysEnd()
	tmr.unregister(3)
	relaysOff()
end
 

