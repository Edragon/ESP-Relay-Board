function array()

array = {"0xFA", "Tutorial"}

for i= 0, 2 do
   print(array[i])
end

end

function byted()

    datadd = "45_FAF%F8F6"
    
    for s in string.gmatch(datadd,"..") do
        print(s)
    end

end

function gsub_first3()

    datadd2 = "45_FAF%F8F6"
    
    new_data = string.gsub(datadd2,"%d+.", "", 1)
    print(new_data)

end

function FA()

    datadd2 = "45_FAF%F8F6"
    
    new_data = string.match(datadd2,"FA.+")
    print(new_data)

end

function tohex(str)
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end))
end
--print (tohex("Hello world!"))

function char_split(str)
    return (str:gsub('.', function (c)
        
    end))
end

--print (char_split("Hello world!"))
