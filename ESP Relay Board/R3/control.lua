local M = {}

-- status pin = 0, alarm 1
-- relay pin = 6 and 7, alarm 2, 3

function M.status_LED(delay)
    gpio.mode(0, gpio.OUTPUT)
    status0 = 0
        
    tmr.alarm(1, delay, 1, function()
        if status0 == 0 then
            status0 = 1
            gpio.write(0, gpio.HIGH)
        else
            status0 = 0
            gpio.write(0, gpio.LOW)
        end 
    end)
      
end

-- One on/off relay
function M.relay_onoff()
-- relay on off twice

    gpio.write(6, gpio.LOW)
    gpio.write(7, gpio.LOW)

    tmr.alarm(2, 1000, tmr.ALARM_AUTO, function()
        if gpio.read(6) == 0 then
            gpio.write(6, gpio.HIGH)
            gpio.write(7, gpio.HIGH)
        else
            gpio.write(6, gpio.LOW)
            gpio.write(7, gpio.LOW) 
        end

    end)

    tmr.alarm(3,4000, 0, function() tmr.stop(2) end)
        
end

-- loop relay
function M.relay_6(delay, mode)
    --gpio.mode(6, gpio.OUTPUT)
    status1 = 0
        
    tmr.alarm(2, delay, mode, function()
        if status1 == 0 then
            status1 = 1
            gpio.write(6, gpio.HIGH)
        else
            status1 = 0
            gpio.write(6, gpio.LOW)
        end 
    end)
      
end


function M.relay_7(delay, mode)
    --gpio.mode(7, gpio.OUTPUT)
    status2 = 0
        
    tmr.alarm(3, delay, mode, function()
        if status2 == 0 then
            status2 = 1
            gpio.write(7, gpio.HIGH)
        else
            status2 = 0
            gpio.write(7, gpio.LOW)
        end 
    end)
      
end

return M
