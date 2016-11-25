
    function tohex( input )
        return (input:gsub( "..", function(c)
            return string.char( tonumber( c, 16 ) )
        end))
    end

    function unhex(str)
        return (str:gsub('.', function (c)
            return string.format('%02X', string.byte(c))
        end))
    end 