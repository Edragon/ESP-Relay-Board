dofile("hex.lua")


function ir_get()
    ir_get_cmd = "FAFD"   
    uart.alt(1)

    for i = 1, #ir_get_cmd, 2 do
        k = string.sub(ir_get_cmd, i, i+1)
        --print (k)
        uart.write(0, tohex(k))
    end
    
    uart.on("data", "\237", function(data)
        local ird
            uart.on("data")
            byte_data = unhex(data)
            cdata = string.match(byte_data,"FA.+") 
                    
            uart.alt(0)
            print ('ir data received!')
            --print (cdata)          
            
    end, 0)
    print (cdata) 
    return cdata       
     
end  
