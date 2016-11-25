--[[IR_cmd = "FAFD"
--print (string.byte(k,1,2))
--print (string.format("%x", 250))

x = "\250"
print (x)

char_cmd = ""
char_cmd2 = ""
for i = 1, #IR_cmd, 2 do

        digi2 = string.sub(IR_cmd, i, i+1)
        print (string.char(tonumber(digi2, 16)))
        char2 = string.format("\%d", tonumber(digi2, 16))
        print (char2)
        char_cmd = char_cmd..char2
end

print (char_cmd)]]

tmr.alarm(1, 200, tmr.ALARM_SINGLE, function() 
    uart.alt(1)
    uart.write(0, "\250\253")
end)

function string_2(data)
    
    for i = 1, #data, 2 do
        k = string.sub(data, i, i+1)
        print (k)
    end
end
