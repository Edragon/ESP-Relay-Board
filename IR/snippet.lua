msg = "55AA24010200010000000000000000000000000000002701"

for i = 1,string.len(msg),2 do
    byte =("0x"..string.sub(msg,0+i,1+i)) 
    uart.write(0,tonumber(byte))
end

--- string to arrary

local str = "text"
local t = {}
for i = 1, #str do
    t[i] = str:sub(i, i)
end


print(string.byte("\r"))
print(string.char(97))         

print(byte.string)

> = s:byte(3,4)               -- can apply directly to string variable
67      68

> = string.char(65,66,67)
ABC
> = string.char()  -- empty string