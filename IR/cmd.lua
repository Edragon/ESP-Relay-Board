
local M = {}

-- write_arry = {0xFA, 0xF5}

function M.IR_write()

    tmr.alarm(0, 200, tmr.ALARM_SINGLE, function() 
        uart.alt(1)
        --uart.setup(0, 9600, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1)
    end)

    tmr.alarm(1, 400, tmr.ALARM_SINGLE, function() 
        uart.write(0, 0xFA, 0xF5) 
    end)

    tmr.alarm(2, 600, tmr.ALARM_SINGLE, function() 
        uart.alt(0)
    end)

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
