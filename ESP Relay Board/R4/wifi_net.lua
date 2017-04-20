sk = net.createServer(net.TCP)

function switch_relay(c)
    if c == "a1" then
        gpio.write(6, gpio.HIGH)
    elseif c == "a0" then
        gpio.write(6, gpio.LOW)
    elseif c == "b1" then
        gpio.write(7, gpio.HIGH)
    elseif c == "b0" then
        gpio.write(7, gpio.LOW)
    else

    end
end
                
sk:listen(80, function(conn)
    conn:on("receive", function(sck, c)
        print("receive socket message:  " .. c)
        conn:send("run command:  " .. c)
        switch_relay(c)
    end)
    
end)
