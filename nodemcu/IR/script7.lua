inkey = "16"

data = "FA81269B8A808002008A9C9B8A0906028ACB8A9C01009C8A8ACC0200899D9C8A09060288CB899D01009D8988CC02008A9C9D890906028ACB8A9C01009C898ACB0200899D9C890906028ACB899D01009D898ACB02008A9C9D890906028ACB8A9C01009D8A8ACC02008A9C9D8A0906028ACB8A9C01009C898ACB02008A9C9C8909060209CCED"

ary = {}
ary[inkey] = data


    for key, value in pairs(ary) do
        print (key .. "   " .. value)
    end