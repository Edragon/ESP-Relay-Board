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