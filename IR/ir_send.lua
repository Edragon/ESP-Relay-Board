--ir_cmd = "FAFD"
dofile("hex.lua")

function ir_send(ir_cmd)
    
    uart.alt(1)

    for i = 1, #ir_cmd, 2 do
        k = string.sub(ir_cmd, i, i+1)
        --print (k)
        tmr.alarm(1, 100, tmr.ALARM_SINGLE, function()
        uart.write(0, tohex(k))
        end
    end
        
    uart.on("data", "\0", function(data)
        uart.alt(0)                             
        print("command readdata correct sent!")
        uart.on("data")

    end, 0)

    tmr.alarm(1, 5000, tmr.ALARM_SINGLE, function()
        uart.on("data")
        uart.alt(0)                             
        print("timeout for error")
    end)

end

function ir_reset()
    IR_reset = {0xFA, 0xF6}    
    uart.alt(1)
    for key, value in ipairs(IR_reset) do uart.write(0, value) end
   
    tmr.alarm(1, 100, tmr.ALARM_SINGLE, function() 
    uart.alt(0) 
    print("IR reset!")
    end)
    
end


--[[
function IR_read_data()
    IR_read = {"\250","\253"}

    uart.alt(1)
    uart.write(0, "\250\253")

    IR_cmd = "FAFD"
    for i = 1, #IR_cmd, 2 do
        k = string.sub(IR_cmd, i, i+1)
        xk = string.format("0x%s", k)
        --print (xk)
        uart.write(0, xk)
    end
    
for key, value in ipairs(IR_read) do 
   uart.write(0, value) end
    
        uart.on("data", "\0", function(data)
            uart.alt(0)                             
            print("command readdata correct sent!")
            uart.on("data")
        end, 0)
    
end]]
