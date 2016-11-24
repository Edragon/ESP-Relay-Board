dofile("file_check.lua")
    
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
    end, 0)
    --print (byte_data)
    return correct_data
end  



function check_write(inkey, wdata)
    print ("start to check and write")
    data_pair = f_read()
    data_pair[inkey] = wdata
    f_write(data_pair)
end      

function data_handle()
    inkey = "16"
    IR_read_data()
    wdata = IR_retrieve_data()
    tmr.alarm(1, 2000, tmr.ALARM_SINGLE, function() 
        print (wdata)
        check_write(inkey, wdata)
    end)    
    
end
