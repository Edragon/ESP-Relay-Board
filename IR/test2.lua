
function tohex(str)
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end))
end
print (tohex("Hello world!"))

function char_split(str)
    return (str:gsub('.', function (c)
        
    end))
end

print (char_split("Hello world!"))
