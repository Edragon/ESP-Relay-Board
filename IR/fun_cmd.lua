    
function IR_read_data()
    IR_read = {0xFA, 0xFD}    
    uart.alt(1)
    for key, value in ipairs(IR_read) do uart.write(0, value) end
    
        uart.on("data", "\0", function(data)
            uart.alt(0)                             
            print("command readdata correct sent!")
            uart.on("data")
        end, 0)
    
end

function IR_reset()
    IR_reset = {0xFA, 0xF6}    
    uart.alt(1)
    for key, value in ipairs(IR_reset) do uart.write(0, value) end
   
    tmr.alarm(1, 100, tmr.ALARM_SINGLE, function() 
    uart.alt(0) 
    print("IR reset!")
    end)
    
end

    
function IR_retrieve_data()
    local byte_data
    function tohex2(str)
        return (str:gsub('.', function (c)
            return string.format('%02X', string.byte(c))
        end))
    end
    
    uart.alt(1)
    
    uart.on("data", "\237", function(data)
        byte_data = tohex2(data)
        correct_data = string.match(byte_data,"FA.+")
        uart.on("data")   
        uart.alt(0)
        print(byte_data)
        file_write(correct_data)
    end, 0)
    --print(byte_data) 
    return byte_data
end  

function file_write(wdata)
    -- write user and pass
    file.remove("IR_ID.txt")
    file.open("IR_ID.txt", "w")
    file.writeline(wdata)
    file.close()
end      

function data_handle()
    IR_read_data()
    IR_retrieve_data()
    print (raw_data)
end