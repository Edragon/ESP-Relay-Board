
local M = {}


    
function M.IR_write()
    IR_read = {0xFA, 0xF5}    
    uart.alt(1)
    for key, value in ipairs(IR_read) do uart.write(0, value) end
    
        uart.on("data", "\0", function(data)
            uart.alt(0)                             
            print("command reset correct sent!")
            uart.on("data")
        end, 0)
    
end

function M.IR_reset()
    IR_reset = {0xFA, 0xF6}    
    uart.alt(1)
    for key, value in ipairs(IR_reset) do uart.write(0, value) end
    
        uart.on("data", "\0", function(data)
            uart.alt(0)                             
            print("command reset correct sent!")
            uart.on("data")
        end, 0)
    
end


function M.IR_read2()
    uart.alt(1)
    uart.alt(0)
    print ("data")
end

function M.IR_read()
    function tohex(str)
        return (str:gsub('.', function (c)
            return string.format('%02X', string.byte(c))
        end))
    end

    uart.alt(1)  
    
    tmr.alarm(1, 100, tmr.ALARM_SINGLE, function() 
    
    --nchar = 0xED
    
    uart.on("data", "\237", function(data)
        ndata = data
        uart.on("data") -- unregister callback function
        --D1 = string.format("%02X", ndata:byte(1))
        --D2 = string.format("%02X", ndata:byte(2))           
              
        uart.alt(0)

        --print (ndata)
        print(tohex(ndata))
        --print("receive D1 " .. D1)
        --print("receive D2 " .. D2)
    end, 0)

    end)
end

return M
