local M = {}

-- status pin = 0
-- relay pin = 6 and 7
-- delay = 500ms

function M.blink0(pin, delay, alarmnm)
    gpio.mode(pin, gpio.OUTPUT)
    blink_status0 = 0
        
    tmr.alarm(alarmnm, delay, 1, function()
        if blink_status0 == 0 then
            blink_status0 = 1
            gpio.write(pin, gpio.HIGH)
        else
            blink_status0 = 0
            gpio.write(pin, gpio.LOW)
        end 
    end)
      
end

function M.blink1(pin, delay, alarmnm)
    gpio.mode(pin, gpio.OUTPUT)
    blink_status1 = 0
        
    tmr.alarm(alarmnm, delay, 1, function()
        if blink_status1 == 0 then
            blink_status1 = 1
            gpio.write(pin, gpio.HIGH)
        else
            blink_status1 = 0
            gpio.write(pin, gpio.LOW)
        end 
    end)
      
end

function M.blink2(pin, delay, alarmnm)
    gpio.mode(pin, gpio.OUTPUT)
    blink_status2 = 0
        
    tmr.alarm(alarmnm, delay, 1, function()
        if blink_status2 == 0 then
            blink_status2 = 1
            gpio.write(pin, gpio.HIGH)
        else
            blink_status2 = 0
            gpio.write(pin, gpio.LOW)
        end 
    end)
      
end
return M
