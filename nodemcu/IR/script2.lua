
      
uart.on("data", 2,
  function(data) 
  --print("receive from uart:", data)
    if data=="F5" then
      print ("receive F5")
      uart.on("data") -- unregister callback function

    end
end, 0)


--uart.write(0, 0xFA)
--uart.write(0,0xF5)
uart.alt(0)

uart.setup(0, 115200, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1)

function string.tohex(str)
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end))
end
