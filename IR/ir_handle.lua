dofile("file_check.lua")
dofile("ir_get.lua")    
dofile("ir_send.lua") 

function ir_learn(inkey)    
    cdata = ir_get()
    print (cdata)
    
    tmr.alarm(1, 5000, tmr.ALARM_SINGLE, function()        
        check_write(inkey, cdata)
    end) 
    
end


function ir_forward(inkey)  
    data_pair = f_read()
    if data_pair[inkey] == nil then
        print ('cmd not exist')
    else
        --[[for key, value in pairs(data_pair) do
            print (key, value)
        end]]
        print(data_pair[inkey])
        ir_send(data_pair[inkey])
    end
end

function check_write(inkey, kdata)
    print ("start to check and write")
    data_pair = f_read()
    data_pair[inkey] = kdata
    
    f_write(data_pair)
end  