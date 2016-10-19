function read_dc()
    i = 0
    result = 0
    tmr.alarm(0, 1, 1, function()
        if i<= 1000 then
            i = i +1
            --print (i)
            C = adc.read(0)
        else
            --tmr.stop(1)
            result = C/1024.0
            print (string.format("%02.3f", result) .. "     raw: " .. C)
            i = 0
        end    
    end)

end

function read_ac()
    gpio.mode(7, gpio.OUTPUT)
    gpio.write(7, gpio.HIGH)
    gpio.mode(6, gpio.OUTPUT)
    gpio.write(6, gpio.HIGH)
    i = 0
    vrms = 0
    Cmin = 1000
    Cmax = 0
    tmr.alarm(0, 1, 1, function()
        if i<= 1000 then
            i = i +1
            --print (i)
            C = adc.read(0)
            if C <= Cmin then
                Cmin = C
            end
            if C >= Cmax then
                Cmax = C
            end
        else
            --tmr.stop(1)
            -- raw_v: ac power = 4-6, usb power = 5-7
            raw_v = Cmax - Cmin
            vrms = raw_v / 2 * 0.707
            arms = vrms * 33.33 - 166.66
            print ("Vrms: " .. string.format("%02.2f", vrms) .. ",   raw data: " .. raw_v)
            print (string.format("%02.2f", arms) .. " mA")
            Cmin = 1000
            Cmax = 0
            i = 0
        end    
    end)

end

function relayb(pin, t_nr, delay)
    gpio.mode(pin, gpio.OUTPUT)
    blink_status1 = 0

    tmr.alarm(t_nr, delay, 1, function()
        if blink_status1 == 0 then
            blink_status1 = 1
            gpio.write(pin, gpio.HIGH)
        else
            blink_status1 = 0
            gpio.write(pin, gpio.LOW)
        end
    end)
    
end

function relayt(pin, t_nr, delay)
    gpio.mode(pin, gpio.OUTPUT)
    blink_status2 = 0

    tmr.alarm(t_nr, delay, 1, function()
        if blink_status2 == 0 then
            blink_status2 = 1
            gpio.write(pin, gpio.HIGH)
        else
            blink_status2 = 0
            gpio.write(pin, gpio.LOW)
        end
    end)
    
end

function relay3(pin, pin2, t_nr, delay)
    gpio.mode(pin, gpio.OUTPUT)
    gpio.mode(pin2, gpio.OUTPUT)
    blink_status1 = 0

    tmr.alarm(t_nr, delay, 1, function()
        if blink_status1 == 0 then
            blink_status1 = 1
            gpio.write(pin, gpio.HIGH)
            gpio.write(pin2, gpio.HIGH)
        else
            blink_status1 = 0
            gpio.write(pin, gpio.LOW)
            gpio.write(pin2, gpio.LOW)
        end
    end)
    
end


read_ac()
--relayb(6,3,10000)
--relayt(7,4,10000)
--relay3(6,7,2,10000)
